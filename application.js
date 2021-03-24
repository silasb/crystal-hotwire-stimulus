import * as Turbo from "@hotwired/turbo"

import { Application } from "stimulus"

import HelloController from './controllers/hello_controller'
import StylingController from './controllers/styling_controller'
import TextInputController from './controllers/text_input_controller'

const application = Application.start()
application.register("hello", HelloController)
application.register("styling", StylingController)
application.register("text-input", TextInputController)