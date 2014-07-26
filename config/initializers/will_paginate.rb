# config/initializers/will_paginate.rb
module WillPaginate
  module ActionView
    def will_paginate(collection = nil, options = {})
      options[:renderer] ||= BootstrapLinkRenderer
      super.try :html_safe
    end

    class BootstrapLinkRenderer < LinkRenderer
      def container_attributes
        super.except(:first_label, :last_label)
      end

      protected

      def html_container(html)
        tag :ul, html, container_attributes
      end

      def pagination
        items = @options[:page_links] ? windowed_page_numbers : []
        items.unshift :previous_page
        items.unshift :first_page
        items.push :next_page
        items.push :last_page
      end

      def page_number(page)
        tag :li, link(page, page, :rel => rel_value(page)), :class => ('active' if page == current_page)
      end

      def previous_or_next_page(page, text, classname)
        tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('disabled' unless page)].join(' ')
      end

      def gap
        #tag :li, link(super, '#'), :class => 'disabled'
      end

      def first_page
        previous_or_next_page(current_page == 1 ? nil : 1, '&laquo;', "first_page")
      end

      def last_page
        previous_or_next_page(current_page == total_pages ? nil : total_pages, '&raquo;', "last_page")
      end
    end
  end

  module ViewHelpers
    # default view options
    self.pagination_options = Deprecation::Hash.new \
      :class          => 'pagination',
      :previous_label => '&#8249;',
      :next_label     => '&#8250;',
      :inner_window   => 2, # links around the current page
      :outer_window   => -2, # links around beginning and end
      :link_separator => ' ', # single space is friendly to spiders and non-graphic browsers
      :param_name     => :page,
      :params         => nil,
      :page_links     => true,
      :container      => true

  end
end