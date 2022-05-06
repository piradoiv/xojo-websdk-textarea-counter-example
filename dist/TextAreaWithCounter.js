"use strict";
var Xojo;
(function (Xojo) {
    class TextAreaWithCounter extends XojoWeb.XojoVisualControl {
        constructor(id, events) {
            super(id, events);
            this.mTextArea = document.createElement('textarea');
            this.mCountLabel = document.createElement('span');
            const el = this.DOMElement('');
            el === null || el === void 0 ? void 0 : el.append(this.mTextArea, this.mCountLabel);
            el === null || el === void 0 ? void 0 : el.classList.add('form-group');
            this.mTextArea.classList.add('form-control');
            this.mTextArea.addEventListener('input', () => {
                this.updateLabel();
            });
        }
        updateControl(data) {
            super.updateControl(data);
            const json = JSON.parse(data);
            if (typeof json.text !== 'undefined') {
                this.mTextArea.value = json.text;
            }
            this.refresh();
        }
        render() {
            super.render();
            const el = this.DOMElement('');
            if (!el)
                return;
            this.setAttributes(el);
            this.updateLabel();
            this.applyTooltip(el);
            this.applyUserStyle(el);
        }
        updateLabel() {
            this.mCountLabel.textContent = this.mTextArea.value.length + '/100';
            this.mCountLabel.classList.toggle('limit-exceeded', this.mTextArea.value.length > 100);
        }
    }
    Xojo.TextAreaWithCounter = TextAreaWithCounter;
})(Xojo || (Xojo = {}));
