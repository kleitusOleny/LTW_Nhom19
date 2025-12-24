// đầu vào là các mảng chứa field input id
function preventspace(listFields) {
    listFields.forEach(selector => {
        const field = document.querySelector(selector);
        if (field) {
            field.addEventListener('keydown', (e) => {
                if (e.key === ' ') e.preventDefault();
            });

            field.addEventListener('input', function() {
                this.value = this.value.replace(/\s/g, '');
            });
        }
    });
}