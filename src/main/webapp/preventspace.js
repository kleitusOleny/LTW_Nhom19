// đầu vào là các mảng chứa field input id
function preventspace(listFields) {
    listFields.forEach(selector => {
        const fields = document.querySelectorAll(selector);
        fields.forEach(field => {
            field.addEventListener('keydown', (e) => {
                if (e.key === ' ') e.preventDefault();
            });

            field.addEventListener('input', function() {
                this.value = this.value.replace(/\s/g, '');
            });
        })
    });
}