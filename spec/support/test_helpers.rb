def check_link(link_text, path)
  link = find_link(link_text, href: path)
  expect(link).to be_present
  expect(link[:href]).to eq(path)
end

def check_button(button_text)
  button = find('input[type="submit"][value="' + button_text + '"]')
  expect(button).to be_present
end