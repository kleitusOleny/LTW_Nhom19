<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="../css/info_user_style.css">


<div class="user-profile-card">
    <h2>Thông tin người dùng</h2>

    <div class="user-info-fields">

        <div class="field">
            <i class="fa-solid fa-user left-icon"></i>
            <span class="editable" data-key="name">Nguyễn Văn A</span>
        </div>

        <div class="field">
            <i class="fa-solid fa-envelope left-icon"></i>
            <span class="editable" data-key="email">nguyenvan@example.com</span>
        </div>

        <div class="field">
            <i class="fa-solid fa-phone left-icon"></i>
            <span class="editable" data-key="phone">0987654321</span>
        </div>

        <div class="field">
            <i class="fa-solid fa-calendar-days left-icon"></i>
            <span class="editable" data-key="dob">01/01/1990</span>
        </div>

        <div class="field old-password-field" style="display:none;">
            <i class="fa-solid fa-lock left-icon"></i>
            <input id="old-password" type="password" placeholder="Nhập mật khẩu cũ">
            <i class="fa-solid fa-eye password-toggle old-pass-eye"></i>
        </div>

        <div class="field">
            <i class="fa-solid fa-lock left-icon"></i>
            <span class="editable" data-key="password">********</span>
            <i class="fa-solid fa-eye password-toggle new-pass-eye"></i>
        </div>

    </div>

    <div class="buttons">
        <button id="edit-btn" class="btn gray">Sửa</button>
        <button id="save-btn" class="btn" style="display:none;">Lưu</button>
        <button id="cancel-btn" class="btn cancel" style="display:none;">Hủy</button>
    </div>
</div>
<script>
    (function () {
        const editBtn = document.getElementById("edit-btn");
        if (!editBtn || editBtn.dataset.initialized) return;
        editBtn.dataset.initialized = true;
        const saveBtn = document.getElementById("save-btn");
        const cancelBtn = document.getElementById("cancel-btn");
        const oldPassField = document.querySelector(".old-password-field");
        const oldPassInput = document.getElementById("old-password");
        const oldPassEye = document.querySelector(".old-pass-eye");
        const newPassEye = document.querySelector(".new-pass-eye");

        let backup = {};

        function attachEyeToggle(icon, input) {
            icon.style.display = "block";

            icon.onclick = () => {
                if (input.type === "password") {
                    input.type = "text";
                    icon.classList.remove("fa-eye");
                    icon.classList.add("fa-eye-slash");
                } else {
                    input.type = "password";
                    icon.classList.remove("fa-eye-slash");
                    icon.classList.add("fa-eye");
                }
            };
        }

        function toggleEditMode(on) {
            const editable = document.querySelectorAll(".editable");

            if (on) {
                oldPassField.style.display = "flex";
                oldPassInput.value = "";
                attachEyeToggle(oldPassEye, oldPassInput);

                editable.forEach(span => {
                    const key = span.dataset.key;
                    backup[key] = key === "gender" ? span.dataset.value : span.textContent;

                    let input;

                    if (key === "password") {
                        input = document.createElement("input");
                        input.type = "password";
                        input.placeholder = "Nhập mật khẩu mới";
                        attachEyeToggle(newPassEye, input);
                    } else if (key === "dob") {
                        input = document.createElement("input");
                        input.type = "date";
                        let p = span.textContent.split("/");
                        input.value = `${p[2]}-${p[1]}-${p[0]}`;
                    } else {
                        input = document.createElement("input");
                        input.type = "text";
                        input.value = span.textContent;
                    }

                    input.classList.add("editable-input");
                    input.dataset.key = key;

                    span.replaceWith(input);
                });

                editBtn.style.display = "none";
                saveBtn.style.display = "inline-block";
                cancelBtn.style.display = "inline-block";
            } else {
                oldPassField.style.display = "none";
                oldPassEye.style.display = "none";
                newPassEye.style.display = "none";

                document.querySelectorAll(".editable-input").forEach(input => {
                    let key = input.dataset.key;
                    let span = document.createElement("span");
                    span.classList.add("editable");
                    span.dataset.key = key;


                    span.textContent = backup[key];


                    input.replaceWith(span);
                });

                editBtn.style.display = "inline-block";
                saveBtn.style.display = "none";
                cancelBtn.style.display = "none";
            }
        }

        editBtn.onclick = () => toggleEditMode(true);
        cancelBtn.onclick = () => toggleEditMode(false);

        saveBtn.onclick = () => {
            alert("Thông tin đã cập nhật!");
            toggleEditMode(false);
        };
    })();
</script>
