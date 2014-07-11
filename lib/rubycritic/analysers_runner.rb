require "rubycritic/adapters/smell/flay"
require "rubycritic/adapters/smell/flog"
require "rubycritic/adapters/smell/reek"
require "rubycritic/adapters/complexity/flog"
require "rubycritic/analysers/churn"
require "rubycritic/analysers/stats"

module Rubycritic

  class AnalysersRunner
    ANALYSERS = [
      SmellAdapter::Flay,
      SmellAdapter::Flog,
      SmellAdapter::Reek,
      ComplexityAdapter::Flog,
      Analyser::Stats
    ]

    def initialize(analysed_files, source_control_system)
      @analysed_files = analysed_files
      @source_control_system = source_control_system
    end

    def run
      ANALYSERS.map do |analyser|
        analyser.new(@analysed_files).run
      end
      Analyser::Churn.new(@analysed_files, @source_control_system).run
    end
  end

end
