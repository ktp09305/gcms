module Gcms
  module CompileTemplates
    extend ActiveSupport::Concern

    included do
      validate :compiled_templates
      # on validation step object has no id,
      # that's why we need additional compile if validation pass
      after_commit :compile_templates, on: [:create, :update]
    end

    protected

    def compiled_templates
      Gcms.template_manager.diagnostics.clear
      register_liquor_template
      return if Gcms.template_manager.compile
      Gcms.template_manager.errors.each do |error|
        splitted_error = error.message.split(':')
        errors.add(:content, [Gcms.template_manager.decorate(error), splitted_error].flatten.join('<br>').gsub(/\s/, '&nbsp;'))
      end
    end

    def register_liquor_template
      if is_a?(Gcms::Template)
        Gcms.template_manager.register_layout(register_id, content, Gcms::ExternalsRegistry.externals.keys)
      elsif is_a?(Gcms::Page)
        Gcms.template_manager.register_template(register_id, content, Gcms::ExternalsRegistry.externals.keys)
      elsif is_a?(Gcms::Snippet)
        Gcms.template_manager.register_partial(register_id, content)
      end
    end

    def compile_templates
      register_liquor_template
      Gcms.template_manager.compile
    end
  end
end
