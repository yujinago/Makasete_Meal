def check_button(link_text, path)
  button = find_link(link_text, href: path)
  expect(button).to be_present
  expect(button[:href]).to eq(path)
end