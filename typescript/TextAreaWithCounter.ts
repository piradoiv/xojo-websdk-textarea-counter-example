namespace Xojo {
    export class TextAreaWithCounter extends XojoWeb.XojoVisualControl {
        private mTextArea = document.createElement('textarea');
        private mTextLimit = 100;
        private mCountLabel = document.createElement('span');

        constructor(id: string, events: string[]) {
            super(id, events);
            const el = this.DOMElement('');
            el?.append(this.mTextArea, this.mCountLabel);

            el?.classList.add('form-group');
            this.mTextArea.classList.add('form-control');

            this.mTextArea.addEventListener('input', () => {
                this.updateLabel();
            });
        }

        updateControl(data: string) {
            super.updateControl(data);

            const json = JSON.parse(data);
            if (typeof json.text !== 'undefined') {
                this.mTextArea.value = json.text;
            }

            if (typeof json.textLimit !== 'undefined') {
                this.mTextLimit = json.textLimit;
            }

            this.refresh();
        }

        render() {
            super.render();
            const el = this.DOMElement('');
            if (!el) return;
            this.setAttributes(el);

            this.updateLabel();

            this.applyTooltip(el);
            this.applyUserStyle(el);
        }

        private updateLabel() {
            this.mCountLabel.textContent = `${this.mTextArea.value.length}/${this.mTextLimit}`;
            this.mCountLabel.classList.toggle('limit-exceeded', this.mTextArea.value.length > this.mTextLimit);
        }
    }
}