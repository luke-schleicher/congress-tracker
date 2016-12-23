module MailerHelper
  def colored_yea_nay(vote_value)
    if vote_value == "Yea"
      "<strong style='color: #3c763d'>Yea:</strong>".html_safe
    elsif vote_value == "Nay"
      "<strong style='color: #a94442'>Nay:</strong>".html_safe
    else
      "<strong>#{vote_value}:</strong>".html_safe
    end
  end
end
