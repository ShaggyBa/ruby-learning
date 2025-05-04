# frozen_string_literal: true

require "test_helper"

class FooterComponentTest < ViewComponent::TestCase
  def test_component_renders_something_useful
    # assert_equal(
    #   %(<span>Hello, components!</span>),
    #   render_inline(FooterComponent.new(message: "Hello, components!")).css("span").to_html
    # )

    render_inline(FooterComponent.new)

    # Пример проверки: содержащий текст “©” или наличие CSS‑класса
    assert_selector "footer", text: /©/
  end
end
