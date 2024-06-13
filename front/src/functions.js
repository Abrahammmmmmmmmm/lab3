document.addEventListener('DOMContentLoaded', () => {
    const loginForm = document.getElementById('login-form');
    if (loginForm) {
        loginForm.addEventListener('submit', handleLogin);
    }
    loadDefaultData();
    initializeRoleBasedDashboards();
});

let subjects = ['大学英语', '大学物理', '高等数学'];
let users = [];
let students = [];
let grades = [];
let paginatedGrades = [];
let currentPage = 1;
const rowsPerPage = 10;

function handleLogin(event) {
    event.preventDefault();
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    const role = document.getElementById('role').value;
    const errorMessage = document.getElementById('error-message');

    const user = users.find(user => user.username === username && user.password === password && user.role === role);
    if (user) {
        localStorage.setItem('role', user.role);
        localStorage.setItem('username', user.username);
        localStorage.setItem('user', JSON.stringify(user));
        redirectToDashboard(user.role);
    } else {
        errorMessage.textContent = '用户名、密码或角色错误';
    }
}

function redirectToDashboard(role) {
    switch(role) {
        case 'student':
            window.location.href = 'student.html';
            break;
        case 'teacher':
            window.location.href = 'teacher.html';
            break;
        case 'admin':
            window.location.href = 'admin.html';
            break;
    }
}

function importData() {
    const fileInput = document.getElementById('file-input');
    const file = fileInput.files[0];
    const reader = new FileReader();

    reader.onload = function(event) {
        const data = JSON.parse(event.target.result);
        users = data.users || users;
        students = data.students || students;
        grades = data.grades ? filterGrades(data.grades) : grades;
        localStorage.setItem('users', JSON.stringify(users));
        localStorage.setItem('students', JSON.stringify(students));
        localStorage.setItem('grades', JSON.stringify(grades));
        document.getElementById('import-status').textContent = '数据导入成功！';
        setTimeout(() => {
            window.location.reload();
        }, 2000);
    };

    reader.onerror = function() {
        document.getElementById('import-status').textContent = '数据导入失败，请重试。';
    };

    if (file) {
        reader.readAsText(file);
    } else {
        document.getElementById('import-status').textContent = '请选择一个文件。';
    }
}

function loadDefaultData() {
    fetch('../data/data.json')
        .then(response => response.json())
        .then(data => {
            users = data.users || [];
            students = data.students || [];
            grades = data.grades || [];
            localStorage.setItem('users', JSON.stringify(users));
            localStorage.setItem('students', JSON.stringify(students));
            localStorage.setItem('grades', JSON.stringify(grades));
        })
        .catch(error => console.error('Error loading default data:', error));
}

function initializeRoleBasedDashboards() {
    const role = localStorage.getItem('role');
    if (role === 'student' && document.getElementById('grades-list')) {
        loadStudentDashboard();
    } else if (role === 'teacher' && document.getElementById('grades-table')) {
        loadTeacherDashboard();
    } else if (role === 'admin' && document.getElementById('admin-dashboard')) {
        loadAdminDashboard();
    }
}

function loadStudentDashboard() {
    const role = localStorage.getItem('role');
    if (role !== 'student') {
        window.location.href = 'index.html';
        return;
    }

    const username = localStorage.getItem('username');
    const studentsData = JSON.parse(localStorage.getItem('students'));
    const gradesData = JSON.parse(localStorage.getItem('grades'));
    const student = studentsData.find(s => s.username === username);
    if (!student) {
        window.location.href = 'index.html';
        return;
    }

    const studentInfo = document.getElementById('student-info');
    studentInfo.innerHTML = `<strong>${student.name}</strong> (${student.id})<br>年龄: ${student.age}`;

    const gradesList = document.getElementById('grades-list');
    gradesList.innerHTML = '';

    const studentGrades = gradesData.filter(grade => grade.studentId === student.id);
    studentGrades.forEach(grade => {
        const subjectGrades = gradesData.filter(g => g.subject === grade.subject);
        const sortedGrades = subjectGrades.sort((a, b) => b.score - a.score);
        const rank = sortedGrades.findIndex(g => g.studentId === student.id) + 1;
        const listItem = document.createElement('li');
        listItem.textContent = `${grade.subject}: ${grade.score} (排名: ${rank})`;
        gradesList.appendChild(listItem);
    });
    // 在loadStudentDashboard函数内部，获取学生成绩后...
    loadStudentGradesChart(studentGrades);
}

function loadTeacherDashboard() {
    const role = localStorage.getItem('role');
    if (role !== 'teacher') {
        window.location.href = 'index.html';
        return;
    }

    const username = localStorage.getItem('username');
    const user = JSON.parse(localStorage.getItem('user'));
    const gradesData = JSON.parse(localStorage.getItem('grades'));
    const studentsData = JSON.parse(localStorage.getItem('students'));

    document.getElementById('teacher-name').textContent = user.username;

    document.getElementById('sort-order').addEventListener('change', () => {
        currentPage = 1;
        loadTeacherGrades(user.subject, gradesData, studentsData, currentPage, rowsPerPage);
    });

    document.getElementById('logout-button').addEventListener('click', logout);

    // 初始加载教师的成绩
    loadTeacherGrades(user.subject, gradesData, studentsData, currentPage, rowsPerPage);
}

function loadTeacherGrades(subject, gradesData, studentsData, page, rows) {
    const sortOrder = document.getElementById('sort-order').value;
    const subjectGrades = gradesData.filter(grade => grade.subject === subject);
    const sortedGrades = subjectGrades.sort((a, b) => sortOrder === 'asc' ? a.score - b.score : b.score - a.score);
    paginatedGrades = [];
    for (let i = 0; i < sortedGrades.length; i += rowsPerPage) {
        paginatedGrades.push(sortedGrades.slice(i, i + rowsPerPage));
    }

    renderPaginatedGrades(page, rows);
    setupPagination(subjectGrades.length, rows, page);
}

function renderPaginatedGrades(page, rows) {
    const gradesTableBody = document.querySelector('#grades-table tbody');
    gradesTableBody.innerHTML = '';
    const pageGrades = paginatedGrades[page - 1];

    pageGrades.forEach(grade => {
        const student = students.find(s => s.id === grade.studentId);
        const row = `<tr>
            <td>${grade.subject}</td>
            <td>${student.name}</td>
            <td><input type="number" value="${grade.score}" data-student-id="${student.id}" data-subject="${grade.subject}" class="score-input"></td>
        </tr>`;
        gradesTableBody.innerHTML += row;
    });

    renderGradesChart(pageGrades); // Render chart with the current page grades

    document.querySelectorAll('.score-input').forEach(input => {
        input.addEventListener('change', (event) => {
            const studentId = event.target.getAttribute('data-student-id');
            const subject = event.target.getAttribute('data-subject');
            const newScore = parseInt(event.target.value);

            const gradeIndex = grades.findIndex(grade => grade.studentId === studentId && grade.subject === subject);
            if (gradeIndex !== -1) {
                grades[gradeIndex].score = newScore;
                localStorage.setItem('grades', JSON.stringify(grades));
                loadTeacherGrades(subject, grades, students, currentPage, rowsPerPage);
            }
        });
    });
}

function setupPagination(totalItems, rowsPerPage, currentPage) {
    const paginationElement = document.getElementById('pagination');
    paginationElement.innerHTML = '';
    const pageCount = Math.ceil(totalItems / rowsPerPage);

    // Previous Button
    const prevButton = document.createElement('button');
    prevButton.innerText = '上一页';
    prevButton.classList.add('page-btn');
    prevButton.disabled = currentPage === 1; // Disable if on the first page
    prevButton.addEventListener('click', () => {
        if (currentPage > 1) {
            currentPage--;
            renderPaginatedGrades(currentPage, rowsPerPage);
            setupPagination(totalItems, rowsPerPage, currentPage);
        }
    });
    paginationElement.appendChild(prevButton);

    // Page Buttons
    for (let i = 1; i <= pageCount; i++) {
        const btn = paginationButton(i, currentPage);
        paginationElement.appendChild(btn);
    }

    // Next Button
    const nextButton = document.createElement('button');
    nextButton.innerText = '下一页';
    nextButton.classList.add('page-btn');
    nextButton.disabled = currentPage === pageCount; // Disable if on the last page
    nextButton.addEventListener('click', () => {
        if (currentPage < pageCount) {
            currentPage++;
            renderPaginatedGrades(currentPage, rowsPerPage);
            setupPagination(totalItems, rowsPerPage, currentPage);
        }
    });
    paginationElement.appendChild(nextButton);
}

function paginationButton(page, currentPage) {
    const button = document.createElement('button');
    button.innerText = page;
    button.classList.add('page-btn');
    if (currentPage === page) {
        button.classList.add('active');
    }
    button.addEventListener('click', () => {
        currentPage = page;
        renderPaginatedGrades(currentPage, rowsPerPage);
        setupPagination(paginatedGrades.length * rowsPerPage, rowsPerPage, currentPage);
    });
    return button;
}

function renderGradesChart(grades) {
    const ctx = document.getElementById('grades-chart').getContext('2d');
    const scoreRanges = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]; // 移除0，让范围从10开始
    const counts = scoreRanges.map(() => 0);

    // 统计每个分数区间内的人数
    grades.forEach(grade => {
        const score = grade.score;
        const rangeIndex = scoreRanges.findIndex(value => score < value); // 简化查找逻辑
        if (rangeIndex >= 0) {
            counts[rangeIndex]++;
        }
    });

    if (window.gradesChart) {
        window.gradesChart.destroy();
    }

    window.gradesChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: scoreRanges.map((value, index) => {
                return index === 0 ? `0-${value}` : `${scoreRanges[index - 1]}-${value}`;
            }),

            datasets: [{
                label: '成绩分布',
                data: counts,
                backgroundColor: 'rgba(75, 192, 192, 1)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: '人数'
                    }
                },
                x: {
                    display: true,
                    title: {
                        display: true,
                        text: '分数范围'
                    }
                }
            }
        }
    });
}

// 学生成绩曲线
// function loadStudentGradesChart(studentGrades) {
//     const ctx = document.getElementById('student-grades-chart').getContext('2d');
//     const subjects = [...new Set(studentGrades.map(grade => grade.subject))];
//
//     // 准备数据集
//     const chartData = subjects.map(subject => {
//         const gradesForSubject = studentGrades.filter(g => g.subject === subject);
//         // 计算每个科目的成绩分布不是必须的，因为我们直接用成绩来绘制
//         return {
//             label: subject, // 科目作为标签
//             data: gradesForSubject.map(g => g.score), // 直接使用成绩作为数据点
//             // backgroundColor: getRandomColor(), // 为每个科目分配随机颜色
//         };
//     });
//
//     // 配置图表
//     new Chart(ctx, {
//         type: 'bar', // 使用柱状图类型
//         data: {
//             labels: subjects, // 科目作为横轴标签
//             datasets: chartData, // 每个科目对应一个数据集
//             backgroundColor: getRandomColor()
//             // labels: subjects,
//             // datasets:
//         },
//         options: {
//             responsive: true,
//             scales: {
//                 y: { // 纵轴配置
//                     beginAtZero: true,
//                     title: {
//                         display: true,
//                         text: '成绩'
//                     }
//                 },
//                 x: { // 横轴配置
//                     display: true,
//                     title: {
//                         display: true,
//                         text: '科目'
//                     }
//                 }
//             },
//             legend: {
//                 position: 'bottom', // 图例位置
//             },
//         },
//     });
// }
function loadStudentGradesChart(studentGrades) {
    const ctx = document.getElementById('student-grades-chart').getContext('2d');

    // Extract unique subjects
    const subjects = [...new Set(studentGrades.map(grade => grade.subject))];

    // Prepare the data for chart
    const chartData = {
        labels: subjects, // Subjects as horizontal labels
        datasets: [{
            label: 'Scores', // A single dataset
            // label:subjects,
            data: subjects.map(subject => {
                const gradesForSubject = studentGrades.filter(g => g.subject === subject);
                return gradesForSubject.length ? gradesForSubject[0].score : 0;
            }),
            backgroundColor: subjects.map(() => getRandomColor()) // Assign random colors
        }]
    };

    // Create the chart
    new Chart(ctx, {
        type: 'bar', // Use bar chart
        data: chartData,
        options: {
            responsive: true,
            scales: {
                y: { // Configure the y-axis
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: '成绩'
                    }
                },
                x: { // Configure the x-axis
                    display: true,
                    title: {
                        display: true,
                        text: '科目'
                    }
                }
            },
            plugins: {
                legend: {
                    position: 'bottom', // Legend position
                }
            }
        }
    });
}

// 随机颜色生成函数
function getRandomColor() {
    return `rgba(${Math.floor(Math.random()*256)}, ${Math.floor(Math.random()*256)}, ${Math.floor(Math.random()*256)}, 0.8)`;
}




function loadAdminDashboard() {
    const role = localStorage.getItem('role');
    if (role !== 'admin') {
        window.location.href = 'index.html';
        return;
    }

    document.getElementById('admin-dashboard').style.display = 'block';
    loadUsers(currentPage);
}

function loadUsers(page = 1) {
    currentPage = page;
    const usersTableBody = document.querySelector('#users-table tbody');
    const usersData = JSON.parse(localStorage.getItem('users'));
    const paginatedUsers = paginate(usersData, rowsPerPage, page);

    usersTableBody.innerHTML = '';
    paginatedUsers.forEach(user => {
        const row = `<tr>
            <td>${user.username}</td>
            <td>${user.role}</td>
            <td>
                <button onclick="editUser('${user.username}')">编辑</button>
                <button onclick="deleteUser('${user.username}')">删除</button>
            </td>
        </tr>`;
        usersTableBody.innerHTML += row;
    });

    setupPagination(usersData.length, rowsPerPage, page);
}

function editUser(username) {
    const usersData = JSON.parse(localStorage.getItem('users'));
    const user = usersData.find(u => u.username === username);
    if (user) {
        const newUsername = prompt('请输入新用户名', user.username);
        const newPassword = prompt('请输入新密码', user.password);
        const newRole = prompt('请输入新角色（admin/teacher/student）', user.role);

        if (newUsername && newPassword && newRole) {
            user.username = newUsername;
            user.password = newPassword;
            user.role = newRole;
            localStorage.setItem('users', JSON.stringify(usersData));
            loadUsers(currentPage); // Reload current page with updated data
        }
    }
}

function deleteUser(username) {
    const usersData = JSON.parse(localStorage.getItem('users'));
    const filteredUsers = usersData.filter(user => user.username !== username);
    localStorage.setItem('users', JSON.stringify(filteredUsers));
    loadUsers(currentPage); // Reload current page with updated data
}

function searchUser() {
    const searchQuery = document.getElementById('search-query').value.toLowerCase();
    const usersData = JSON.parse(localStorage.getItem('users'));
    const user = usersData.find(u => u.username.toLowerCase() === searchQuery || u.role.toLowerCase() === searchQuery);
    if (user) {
        displayUserDetails(user);
    } else {
        alert('未找到用户');
    }
}

function displayUserDetails(user) {
    const userDetailSection = document.getElementById('user-detail');
    userDetailSection.innerHTML = `
        <h2>用户详细信息</h2>
        <p>用户名: ${user.username}</p>
        <p>角色: ${user.role}</p>
        <button onclick="editUser('${user.username}')">编辑用户</button>
        <button onclick="deleteUser('${user.username}')">删除用户</button>
    `;
}

function addUser() {
    const username = prompt('请输入新用户名');
    const password = prompt('请输入新密码');
    const role = prompt('请输入角色（admin/teacher/student）');

    if (username && password && role) {
        const usersData = JSON.parse(localStorage.getItem('users'));
        usersData.push({ username, password, role });
        localStorage.setItem('users', JSON.stringify(usersData));
        loadUsers(currentPage); // Reload current page with updated data
    }
}

function logout() {
    localStorage.removeItem('role');
    localStorage.removeItem('username');
    window.location.href = 'index.html';
}

function exportData() {
    const data = {
        users: JSON.parse(localStorage.getItem('users')),
        students: JSON.parse(localStorage.getItem('students')),
        grades: JSON.parse(localStorage.getItem('grades'))
    };
    const dataStr = JSON.stringify(data);
    const dataUri = 'data:application/json;charset=utf-8,' + encodeURIComponent(dataStr);

    const exportFileDefaultName = '../data/data.json';

    const linkElement = document.createElement('a');
    linkElement.setAttribute('href', dataUri);
    linkElement.setAttribute('download', exportFileDefaultName);
    linkElement.click();
}