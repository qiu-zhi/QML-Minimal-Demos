// JavaScript 函数用于执行 IPv4 / IPv6 校验
function validateIp(ip) {

    // ================== IPV4 ==================
    // IPv4 正则表达式：
    var ipv4Regex = /^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9][0-9]|[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9][0-9]|[0-9])$/;

    // ================== IPV6 ==================
    // IPv6 正则表达式非常长且复杂，且需要处理零压缩和 IPv4 嵌入等情况
    // 至少包含 1 到 8 组 1-4 位十六进制数，用冒号分隔，或使用双冒号压缩。
    // 对于生产环境，建议使用 C++ 后端（如 QHostAddress::setAddress）进行精确校验。
    var ipv6Regex = /^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$/i;

    if (ip.trim() === "") {
        ipStatus.text = "请输入 IP 地址";
        ipStatus.color = "blue";
        ipTextField.palette.text = "black";
    } else if (ip.match(ipv4Regex)) {
        ipStatus.text = "格式校验通过：这是一个有效的 IPv4 地址";
        ipStatus.color = "green";
        ipTextField.palette.text = "green";
    } else if (ip.match(ipv6Regex)) {
        // 提示：正则表达式可能无法完全覆盖所有有效的 IPv6 缩写形式。
        ipStatus.text = "格式校验通过：这是一个有效的 IPv6 地址";
        ipStatus.color = "green";
        ipTextField.palette.text = "green";
    } else {
        ipStatus.text = "格式校验失败：无效的 IPv4 或 IPv6 地址";
        ipStatus.color = "red";
        ipTextField.palette.text = "red";
    }
}

// JavaScript 函数用于身份证号格式的校验
function validateIDCard(id) {

    // ================== 身份证 ==================
    var idcard = /^[1-9]\d{5}(19|20|(3\d))\d{2}((0[1-9])|(1[0-2]))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/;

    if (id.trim() === "") {
        idStatus.text = "请输入身份证号";
        idStatus.color = "blue";
        idTextField.palette.text = "black";
    } else if (id.match(idcard)) {
        idStatus.text = "格式校验通过：这是一个有效的身份证号";
        idStatus.color = "green";
        idTextField.palette.text = "green";
    } else {
        idStatus.text = "格式校验失败：无效的身份证号";
        idStatus.color = "red";
        idTextField.palette.text = "red";
    }
}
