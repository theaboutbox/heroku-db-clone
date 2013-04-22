require 'trollop'

module HerokuDbClone
  class Client
    def initialize
      @opts = Trollop::options do
        opt :capture, "Capture a fresh database backup", short: '-c'
        opt :drop, "Drop the local database before importing the captured copy", short: '-d'
        opt :keep, "Do not delete the downloaded backup file", short: '-k'
        opt :verbose, "Verbose console output", short: '-v'
        opt :dump_name, "Name of the dump to download", type: :string, default: 'db.dump'
      end

      @app_name = ARGV.shift
      raise "Please specify a Heroku app name" if @app_name.nil?

      load_db_information 

      log "Capturing Database for #{@app_name}"
    end

    def run
      capture if @opts[:capture]
      download
      drop if @opts[:drop]
      import
      clean_up unless @opts[:keep]
    end

    def capture
      log "Capturing production database snapshot..."
      exec "heroku pgbackups:capture --expire --app #{@app_name}"
    end

    def download
      log "Downloading snapshot..."
      exec "curl -o #{@opts[:dump_name]} \`heroku pgbackups:url --app #{@app_name}\`"
    end

    def drop
      log "Dropping Existing Database"
      exec "dropdb #{@db_name}" rescue nil
      exec "createdb -T template0 #{@db_name}" rescue nil
    end

    def import
      pg_cmd = []
      pg_cmd << 'pg_restore --verbose --clean --no-acl --no-owner'
      pg_cmd << "-h #{options[:host]}" if @db_host
      pg_cmd << "-U #{options[:user]}" if @db_user
      pg_cmd << "-d #{@db_name} #{@opts[:dump_name]}"
      cmd = pg_cmd.join(' ')
      exec cmd
    end

    def clean_up
      exec "rm #{@opts[:dump_name]}"
    end

    # Internal: Prints an output message if the verbose option is true
    def log(msg)
      puts msg if @opts[:verbose]
    end

    # Runs a command, outputting the command and output if verbose is true
    def exec(cmd)
      log cmd
      log `#{cmd}`
    end

    # Internal: Get the configuration of the local development database
    def load_db_information 
      raise "config/database.yml does not exist at the current location: #{File.expand_path('.')}" unless File.exists?('config/database.yml')
      dev_db = YAML.load_file('config/database.yml')["development"]
      @db_name     = dev_db["database"]
      @db_user     = dev_db['username']
      @db_password = dev_db['password']
      @db_host     = dev_db['host']
    end
  end
end
