import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "output" ]
  static values = { number: Number }
  connect() {
    this.numberValueChanged()
  }

  clicked() {
    this.numberValue++
  }

  numberValueChanged() {
    this.outputTarget.textContent = this.numberValue
  }
}