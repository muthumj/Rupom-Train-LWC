import { createElement } from 'lwc';
import Lwc_Default_ModalBox from 'c/lwc_Default_ModalBox';

describe('c-lwc-default-modal-box', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('TODO: test case generated by CLI command, please fill in test logic', () => {
        // Arrange
        const element = createElement('c-lwc-default-modal-box', {
            is: Lwc_Default_ModalBox
        });

        // Act
        document.body.appendChild(element);

        // Assert
        // const div = element.shadowRoot.querySelector('div');
        expect(1).toBe(1);
    });
});