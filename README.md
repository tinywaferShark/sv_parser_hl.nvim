
# nvim-uvm-log-highlight

一个用于 Neovim 的插件，专门用于高亮显示 UVM 日志文件中的关键字，并提供额外的日志文件浏览功能，如折叠、跳转等。

## 功能概览

- **高亮显示 UVM 消息**  
  支持对 UVM 日志中常见消息级别（INFO、WARNING、ERROR 等）、时间戳、组件路径等部分进行语法高亮显示，提升日志可读性。

- **折叠日志块**  
  当日志中存在结构化信息（如启动、初始化、流程、结束等阶段）时，自动根据配置将部分日志折叠，便于快速定位关键内容。  
  > 注意：插件在当前折叠模块中包含打印提示（例如 "Fold setup complete"），可根据需要自行调整或删除。

- **跳转与导航**  
  支持基于正则表达式的日志信息搜索，帮助用户快速跳转到错误或警告信息所在位置。

- **自定义配置**  
  用户可以在 Neovim 的配置文件中实现对关键词高亮、折叠规则、正则搜索等的自定义设置，以适应不同格式的 UVM 日志文件。

## 安装

使用 [vim-plug](https://github.com/junegunn/vim-plug)、[packer.nvim](https://github.com/wbthomason/packer.nvim) 或其他 Neovim 插件管理器安装：

### vim-plug 示例

```vim
Plug 'yourusername/nvim-uvm-log-highlight'
```

### packer.nvim 示例

```lua
use 'yourusername/nvim-uvm-log-highlight'
```

安装后，重启 Neovim 并运行插件管理器的更新或安装命令，例如 `:PlugInstall` 或 `:PackerSync`。

## 使用说明

1. **文件类型检测**  
   当你打开以 `.log` 后缀结尾的文件，插件将自动加载并应用 UVM 日志的语法高亮规则。如果你的日志文件使用了其他扩展名，可在 `ftdetect` 中添加对应设置。

2. **高亮显示**  
   插件会查找 UVM 日志中常见的关键字（如 `UVM_INFO`、`UVM_WARNING`、`UVM_ERROR` 等）并进行高亮显示。你可以在插件的配置文件中调整所使用的高亮组和颜色方案。

3. **折叠功能**  
   插件会使用自带的 folding 模块初始化折叠设置，自动将日志按结构折叠。  
   - 若不需要折叠输出信息 "Fold setup complete"，请在 `folding.lua` 文件中删除或注释掉打印代码：
     
     ```lua
     -- print("Fold setup complete")
     ```

4. **日志导航**  
   使用 Neovim 内置的搜索命令（如 `/` 或 `?`）结合日志中高亮关键词快速查找错误、警告信息等。
   
5. **自定义设置**  
   在你的 Neovim 配置文件中，可以通过设置全局变量或调用插件提供的配置函数来自定义行为，例如：
   
   ```lua
   require('nvim-uvm-log-highlight').setup({
     highlight = {
       info = "UVMInfo",
       warning = "UVMWarning",
       error = "UVMError",
     },
     folding = {
       enable = true,
       method = "syntax", -- 或者 'expr' 等其他方式
     },
     navigation = {
       -- 可添加自定义跳转逻辑等
     }
   })
   ```

## 示例 UVM Log 文件

下面是一个示例 UVM 日志文件，用于测试插件效果，你可以保存为 `uvm_sample.log` 后在 Neovim 中打开查看高亮与折叠效果：

```log
// UVM Log Sample File

// 仿真启动日志
10.000 ns : UVM_INFO @ testbench.sv(45) : uvm_test_top :: Simulation starting...

// 初始化阶段
20.123 ns : UVM_INFO @ uvm_component.svh(123) : testbench.subsystem :: Component initialized.
30.456 ns : UVM_WARNING @ uvm_component.svh(130) : testbench.subsystem :: Potential issue detected during initialization.

// 执行仿真过程
50.789 ns : UVM_INFO @ uvm_transaction.svh(75) : testbench.subsystem.agent.agent_env :: Transaction started.
60.000 ns : UVM_ERROR @ uvm_driver.svh(90) : testbench.subsystem.agent.driver :: Packet dropped due to timeout.
70.111 ns : UVM_INFO @ uvm_scoreboard.svh(110) : testbench.subsystem.agent.scoreboard :: Checking transaction response.

// 收尾阶段
80.222 ns : UVM_INFO @ uvm_component.svh(130) : testbench.subsystem :: Component shutdown sequence initiated.
90.333 ns : UVM_INFO @ testbench.sv(150) : uvm_test_top :: Simulation finished.

// 仿真结束日志
100.444 ns : UVM_INFO @ uvm_report_server.svh(60) : uvm_report_server :: Total errors = 1, warnings = 1.
```

## 贡献

欢迎提交 issue 和 pull request，共同完善该插件功能。如果你有功能需求或者 bug 反馈，请在 GitHub 上创建新的 issue。

## 许可

该项目遵循 MIT 许可协议。详细内容请参阅 [LICENSE](LICENSE) 文件。

---

Happy logging!
