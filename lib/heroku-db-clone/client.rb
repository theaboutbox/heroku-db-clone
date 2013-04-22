module HerokuDbClone
  class Client
    def initialize
      @opts = Trollop::options do
        opt :capture, "Capture a fresh database backup"
        opt :drop, "Drop the local database before importing the captured copy", short: '-d'
        opt :keep, "Do not delete the downloaded backup file", short: '-k'
        opt :verbose, "Verbose console output", short: '-v'
      end

      @app_name = ARGV.shift

      log "Capturing Database for #{@app_name}"
    end

    def run

    end

    # Internal: Prints an output message if the verbose option is true
    def log(msg)
      puts msg if @opts[:verbose]
    end
  end
end
