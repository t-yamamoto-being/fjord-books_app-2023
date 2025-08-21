# frozen_string_literal: true

module ApplicationHelper
  # localeに応じて複数形の表記を変える
  # - 日本語の場合 => 本
  # - 英語の場合 => books
  def i18n_pluralize(word)
    I18n.locale == :ja ? word : word.pluralize
  end

  # localeに応じてエラー件数の表記を変える
  # - 日本語の場合 => 3件のエラー
  # - 英語の場合 => 3 errors
  def i18n_error_count(count)
    I18n.locale == :ja ? "#{count}件の#{t('views.common.error')}" : pluralize(count, t('views.common.error'))
  end

  def format_content(content)
    return '' if content.blank?

    escaped_content = ERB::Util.html_escape(content)
    content_with_links = process_report_links(escaped_content)
    content_with_links = process_external_links(content_with_links)
    format_lines_with_breaks(content_with_links)
  end

  private

  def process_report_links(content)
    processed_urls = Set.new

    content.gsub(%r{(https?://[^/]*)?/reports/(\d+)}i) do |match|
      next match if processed_urls.include?(match)

      report_id = ::Regexp.last_match(2)
      if Report.exists?(report_id)
        processed_urls.add(match)
        %(<a href="/reports/#{report_id}">#{match}</a>)
      else
        match
      end
    end
  end

  def process_external_links(content)
    content.gsub(%r{(https?://[^\s<>"{}|\\^`\[\]]+)}i) do |match|
      if match.match?(%r{/reports/\d+})
        match
      else
        %(<a class="external-link" href="#{match}" target="_blank" rel="noopener noreferrer">#{match}</a>)
      end
    end
  end

  def format_lines_with_breaks(content)
    content.split("\n").map { |line| line.presence || '<br>' }.join
  end
end
