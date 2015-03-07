defmodule PhoenixLinguistTest.I18n do
  use Linguist.Vocabulary

  locale "fr", [
             flash: [
                     notice: [
                             hello: "salut"
                         ],
                     interpolation_at_beginning: "%{name} at beginning",
                 ]
         ]

  locale "en", [
             flash: [
                     notice: [
                             hello: "hello"
                         ],
                     interpolation_at_beginning: "%{name} at beginning",
                 ]
         ]
end
