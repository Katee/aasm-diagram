require 'aasm-diagram'
require 'rails'

module AASMDiagram
  class Railtie < Rails::Railtie
    railtie_name :aasm_diagram

    rake_tasks do
      path = File.expand_path(__dir__)
      Dir.glob("#{path}/tasks/*.rake").each { |f| load f }
    end
  end
end
