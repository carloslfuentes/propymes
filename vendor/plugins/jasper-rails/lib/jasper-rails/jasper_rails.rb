# JasperRails
module JasperRails
  
  def cache_hack
    if request.env['HTTP_USER_AGENT'] =~ /msie/i
      headers['Pragma'] = ''
      headers['Cache-Control'] = ''
    else
      headers['Pragma'] = 'no-cache'
      headers['Cache-Control'] = 'no-cache, must-revalidate'
    end
  end
  
  def buffer_jasper_report (opts = {})
    ac = ActionController::Base.new()
    opts[:xml] = ac.render_to_string(:template => opts[:template].to_s , :layout => false, :locals => { :document => opts[:document] } )
    #jasper file should be a paramater.... I need to fix this.
    opts.reverse_merge!({:jasper_file => opts[:jasper_file], :format => 'pdf'})
    return JasperReport.generate(opts)
  end
  
  def render_jasper_report(opts = {})
    found=false
    unless opts[:xml]
      if opts[:xml_template]
          opts[:xml] = render_to_string(:template => opts[:xml_template], :layout => false)
          opts[:select_criteria] ||= "/#{opts[:collection].first.class.to_s.demodulize.underscore.pluralize}/#{opts[:collection].first.class.to_s.demodulize.underscore}"  
      else
        view_paths.each do |path|
          if File.exist?("#{path}/#{params[:controller]}/#{params[:action]}.xml.builder")
            found=true 
          end
        end
        if (found)
          opts[:xml] = render_to_string(:template => "#{params[:controller]}/#{params[:action]}.xml.builder", :layout => false)      
          opts[:select_criteria] ||= "/#{opts[:collection].first.class.to_s.demodulize.underscore.pluralize}/#{opts[:collection].first.class.to_s.demodulize.underscore}" 
        elsif opts[:object].respond_to?(:to_xml)
          opts[:xml] = opts[:object].to_xml
          opts[:select_criteria] ||= "/#{opts[:object].class.to_s.demodulize.underscore}"
        elsif opts[:collection].respond_to?(:to_xml)
          opts[:xml] = opts[:collection].to_xml
          opts[:select_criteria] ||= "/#{opts[:collection].first.class.to_s.demodulize.underscore.pluralize}/#{opts[:collection].first.class.to_s.demodulize.underscore}"
        end
      end
    end
    raise(RuntimeError,"#{params[:action]}.xml.builder not found in views") unless opts[:xml]
    opts.reverse_merge!({:jasper_file => "#{params[:controller]}/#{params[:action]}", :format => 'pdf'})
    cache_hack
    mime_type='application/'+opts[:format]
    send_data JasperReport.generate(opts), :filename => (opts[:filename] || "report.pdf"), :type => mime_type, :disposition => 'inline'
  end
  
end

require 'action_controller'
ActionController::Base.send :include, JasperRails