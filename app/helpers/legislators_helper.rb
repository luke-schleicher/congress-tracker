module LegislatorsHelper
  def colored_yea_nay(vote_value)
    if vote_value == "Yea"
      "<strong class='text-success'>Yea:</strong>".html_safe
    elsif vote_value == "Nay"
      "<strong class='text-danger'>Nay:</strong>".html_safe
    else
      "<strong>#{vote_value}:</strong>".html_safe
    end
  end
end
