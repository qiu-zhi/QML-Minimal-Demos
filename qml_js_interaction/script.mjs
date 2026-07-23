// WorkerScript 工作线程脚本
// 这个脚本在独立线程中运行，不会阻塞主UI线程

// 计算斐波那契数列（递归，耗时操作）
function fibonacci(n) {
    function fib(n) {
        if (n <= 1) return n;
        return fib(n - 1) + fib(n - 2);
    }
    return fib(n);
}

// 监听主线程发送的消息
WorkerScript.onMessage = function(message) {
    console.log("Worker received message:", JSON.stringify(message));

    try {
        var startTime = Date.now();
        var result;

        // 计算斐波那契数列
        result = fibonacci(message.n || 30);
        console.log("fibonacci result: " + result);

        var endTime = Date.now();
        var processingTime = endTime - startTime;

        // 将结果发送回主线程
        WorkerScript.sendMessage({
            result: result,
            time: processingTime,
            taskId: message.taskId,
            originalMessage: message
        });

    } catch (error) {
        // 错误处理
        WorkerScript.sendMessage({
            error: error.toString(),
            originalMessage: message
        });
    }
}
