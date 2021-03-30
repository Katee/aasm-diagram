namespace :'aasm-diagram' do
  desc 'Generate AASM diagram for the given model and (optionally) state machine'
  task :generate, [:model, :smn] => :environment do |_task, args|
    puts 'Missing `model` argument.' unless args[:model].present?
    model_klass = args[:model].camelize.safe_constantize
    puts 'Invalid `model` argument.' unless model_klass

    smn = args[:smn]&.to_sym

    model_instance = model_klass.new

    output_dir = ENV.fetch('AASM_DIAGRAM_OUTPUT_DIR') { './tmp' }
    output = File.join([output_dir, "#{args[:model]}-#{args[:smn] || 'default'}.png"])

    AASMDiagram::Diagram.new(
      smn && model_instance.aasm(smn) || model_instance.aasm,
      output
    )
  end
end
