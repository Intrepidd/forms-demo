import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['form']

  submit() {
    if (!this.hasFormTarget) return
    this.formTarget.requestSubmit()
  }

  refresh() {
    const hiddenInput = Object.assign(document.createElement('input'), {
      type: 'hidden',
      name: 'refresh_form',
      value: '1'
    })
    this.formTarget.appendChild(hiddenInput)
    this.formTarget.setAttribute('novalidate', 'novalidate')
    this.submit()
  }
}
