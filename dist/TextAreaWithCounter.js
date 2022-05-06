"use strict";
var Xojo;
(function (Xojo) {
    class TextAreaWithCounter extends XojoWeb.XojoVisualControl {
        constructor(id, events) {
            super(id, events);
            this.mTextArea = document.createElement('textarea');
            this.mTextLimit = 100;
            this.mCountLabel = document.createElement('span');
            this.mAllowExceedLimit = true;
            const el = this.DOMElement('');
            el === null || el === void 0 ? void 0 : el.append(this.mTextArea, this.mCountLabel);
            el === null || el === void 0 ? void 0 : el.classList.add('form-group');
            this.mTextArea.classList.add('form-control');
            this.mTextArea.addEventListener('input', () => {
                if (!this.mAllowExceedLimit) {
                    this.mTextArea.value = this.mTextArea.value.substring(0, this.mTextLimit);
                }
                if (this.mTextArea.value.length > this.mTextLimit) {
                    this.triggerServerEvent('LimitExceeded', new XojoWeb.JSONItem(), false);
                }
                this.updateLabel();
            });
        }
        updateControl(data) {
            super.updateControl(data);
            const json = JSON.parse(data);
            if (typeof json.text !== 'undefined') {
                this.mTextArea.value = json.text;
            }
            if (typeof json.textLimit !== 'undefined') {
                this.mTextLimit = json.textLimit;
            }
            this.mAllowExceedLimit = json.mAllowExceedLimit;
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
            this.mCountLabel.textContent = `${this.mTextArea.value.length}/${this.mTextLimit}`;
            this.mCountLabel.classList.toggle('limit-exceeded', this.mTextArea.value.length > this.mTextLimit);
        }
    }
    Xojo.TextAreaWithCounter = TextAreaWithCounter;
})(Xojo || (Xojo = {}));
