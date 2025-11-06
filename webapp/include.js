function includeHTML() {
    const elements = document.querySelectorAll('[data-include]');
    elements.forEach(el => {
        const file = el.getAttribute('data-include');
        fetch(file)
            .then(response => {
                if (!response.ok) throw new Error(`Không tải được ${file}`);
                return response.text();
            })
            .then(html => el.innerHTML = html)
            .catch(err => console.error(err));
    });
}

document.addEventListener('DOMContentLoaded', includeHTML);
