When /^I delete the (\d+)(?:st|nd|rd|th) "([^\"]*)"$/ do |pos, resource_name|
  case resource_name
  when 'scholarship_iteration' then visit eval("scholarship_program_iterations_path(@program)")
  else
    visit eval("#{resource_name.pluralize}_path")
  end
  
  within(:row, pos.to_i) { find(:xpath, ".//a[contains(text(), 'Actions')]").click }
  
  page.execute_script 'window.confirm = function () { return true }'
  click_link I18n.t('general.destroy')
end