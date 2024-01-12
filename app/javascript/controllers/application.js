import { Application } from "@hotwired/stimulus"
import { Autocomplete } from 'stimulus-autocomplete'

const application = Application.start()
application.register('autocomplete', Autocomplete) //コンポーネントにあるAutocompleteコントローラを使えるようにするための記述
// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
