/**
 * @param {string} modalId - ID của modal
 * @param {string} openBtnId - ID của nút mở modal
 * @param {string} closeBtnId - ID của nút đóng modal
 * Tất cả các thuộc tính đầu vào đều dùng ID
 */
function setupModal(modalId, openBtnId, closeBtnId) {
    const modal = document.getElementById(modalId);
    if (!modal) return;
    document.addEventListener('click', function (event) {
        // Xử lý nút Mở Modal
        const openBtn = event.target.closest('#' + openBtnId);
        if (openBtn) {
            modal.classList.add('show');
        }

        // Xử lý nút Đóng Modal
        const closeBtn = event.target.closest('#' + closeBtnId);
        if (closeBtn) {
            modal.classList.remove('show');
        }

        // Đóng khi click ra ngoài vùng modal content
        if (event.target === modal) {
            event.target.classList.remove('show');
        }
    });
}

/**
 *  Xử lý các modal lặp lại trong danh sách
 */
function setupDynamicModals(triggerClass, closeClass) {
    document.addEventListener('click', function (event) {
        const openBtn = event.target.closest('.' + triggerClass);
        if (openBtn) {
            const modalId = openBtn.getAttribute('data-target');
            const modal = document.getElementById(modalId);
            if (modal) modal.classList.add('show');
        }

        const closeBtn = event.target.closest('.' + closeClass);
        if (closeBtn) {
            const modal = closeBtn.closest('[class^="modal-overlay"]');
            if (modal) modal.classList.remove('show');
        }

        if (event.target.className && typeof event.target.className === 'string' && event.target.className.includes('modal-overlay')) {
            event.target.classList.remove('show');
        }
    });
}