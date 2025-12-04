/**
 * @param {string} modalId - ID của modal
 * @param {string} openBtnId - ID của nút mở modal
 * @param {string} closeBtnId - ID của nút đóng modal
 * Tất cả các thuộc tính đầu vào đều dùng ID
 */
function setupModal(modalId, openBtnId, closeBtnId) {
    const modal = document.getElementById(modalId);
    const openBtn = document.getElementById(openBtnId);
    const closeBtn = document.getElementById(closeBtnId);

    function showModal() {
        modal.classList.add('show');
    }

    function hideModal() {
        modal.classList.remove('show');
    }

    openBtn.addEventListener('click', showModal);
    closeBtn.addEventListener('click', hideModal);
    modal.addEventListener('click', function (event) {
        if (event.target === modal) {
            hideModal();
        }
    });
}