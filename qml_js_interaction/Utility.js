.pragma library // 必须使用此指令，确保所有QML实例共享一个JS上下文

function formatDate(date) {
    return date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate()
}

function toUpperCase(name) {
    return name.trim().toUpperCase()
}
