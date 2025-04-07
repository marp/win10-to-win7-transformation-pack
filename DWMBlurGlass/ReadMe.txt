本软件是免费开源软件 使用LGPLv3许可证
This software is free open source software Use LGPLv3 license.
https://github.com/Maplespe/DWMBlurGlass

第一次使用请先下载符号(当前内置了win11 23h2和win10 22h2的符号 如果显示无效则需要下载)
如果无法下载符号 请使用代理 符号服务器是微软服务器 部分地区可能被墙

You need to download the symbols when you use it for the first time (currently built-in symbols for Win11 23h2 and Win10 22h2, if they are invalid, you need to download them).
If you can't download the symbols, please use a proxy. The symbol server is a Microsoft server and may be walled off in some areas.

更新日志(Update log):

2.3.1 - 2025-3-12
增加了一个选项 "关闭Dcomp帧率限制" 在"高级"页面, 允许你解除背景的30帧刷新率限制
增加了一个内置优化, 标题栏字幕按钮的颜色现在会根据你设置的混合颜色自动切换亮暗样式
崩溃信息弹窗增加了一个"重试"按钮, 如果dwm崩溃, 可以点击"重试"尝试重新加载DWMBlurGlass

稳定性改善和优化 GUI样式优化
缩减了生成dump文件时的体积

修复了24H2修改文本颜色无效的bug
修复启用"还原win7样式标题栏按钮尺寸"后导致按钮错位或dwm概率崩溃的问题
修复"启用win7样式标题栏按钮发光效果"没有对帮助按钮添加发光效果的问题
修复Aero效果Alpha颜色不正确的问题
修复Acrylic效果噪点纹理显示不正确的问题
修复Luminosity参数在Mica效果下不生效的问题
修复在启动一些基于Electron框架或者Dcomp合成背景的应用程序缺失预览视图与缩略图 并造成崩溃的问题
修复在启用"使用系统主题色RGB取代颜色设置RGB"选项时 DWM概率崩溃的问题

Added an option "Disable Dcomp framerate limit" in the "Advanced" page that allows you to disable the 30 fps framerate limit for backgrounds.
Added a built-in optimization, the caption button color now automatically switches between light and dark styles based on the Blend color you set.
Added a "Retry" button in the crash message popup window, if dwm crashes, you can click "Retry" to try to reload DWMBlurGlass.

Stability improvement and optimization. GUI style optimization.
Reduced size when generating dump files.

Fixed the bug that modifying text color in 24H2 is invalid.
Fixed the issue of button misalignment or DWM probability crash caused by enabling "Restore Win7 style title bar button size".
Fixed the issue where the "Enable Win7 style title bar button glow" did not add a glow effect to the Question button.
Fix the issue of incorrect Alpha color of Aero effect.
Fix the issue of incorrect display of Acrylic effect noise texture.
Fix the issue that Luminosity parameter doesn't work with Mica effect.
Fix the issue of missing preview views and thumbnails and causing a crash when launching 
some applications based on Electron framework or Dcomp composite backgrounds.
Fix a probable crash of DWM when "Use Accent color to override color settings RGB" option is enabled.


翻译更新:
感谢(按提交顺序):
Translation Updates.
Thanks (in order of last submission):

Russian(ru-Ru) - @shikulja
Spanish(es) - @xoascf
Italian(it-IT) @LuisYeah1234-hub
Traditional Chinese(zh-TW) @railyinu
European Portuguese(pt-PT) @Blackshot3312

2.3.0 - 2024-11-27
本次版本重构了大部分的代码以带来更好的稳定性和性能
支持了Windows 11 24H2 #402 #405

增加了新的选项"启用win7样式标题栏按钮发光效果" (仅限CustomBlur方法) #23
增加了新的选项"在省电模式下关闭效果" 允许你在省电模式下依然启用DWMBlurGlass(仅限CustomBlur方法)
增加了新的选项"启用模糊渲染优化" 如果启用渲染优化 将降低系统模糊效果的质量以及内核规模来降低GPU使用 但模糊质量会下降 #200 #243 #343
增加了异常转储功能，如果dwm发生崩溃将在“data\dumps”目录生成存转储文件 在报告bug时将它提供给我们以便开发者分析和解决问题
将GUI从MiaoUI Core迁移到了开源的MiaoUI Lite 现在你可以自由编译完整的项目包括GUI

优化和修复了Windows10的面剔除优化 默认开启 #200 #243 #343

修复了GUI中修改HEX颜色值不生效的bug #307
修复了Aero反射在多显示器截断的bug #136 #241 #280
修复了RTL文本镜像的问题 #138
修复了部分应用程序的呈现效果不正常 #219 #268 #320
修复了覆盖Accent功能导致部分应用背景透明的和颜色错误bug #285 #289 #304 #329 #338
修复了使用系统Accent颜色的情况下重启后没有正确生效的bug #299
修复了重启dwm进程后没有正确跟随系统透明效果和省电模式选项的bug #301

稳定性改善和优化 #296 #346 #390

翻译更新:
感谢(按提交顺序)
Russian(ru-Ru) - @shikulja
Spanish (es-ES) - @xoascf
Turkish (tr-TR) - @baglayan
Italian (it-IT) - @LuisYeah1234-hub
Korean (ko-KR) - @Longhorn004
Trad.Chinese (zh-TW) - @railyinu
Vietnamese (vi-VN) - @reggyxt
German (de-DE) - @akaydev-coder
Japanese (ja-JP) - @reshP-0325

#

This release refactors most of the code to bring better stability and performance.
Added support for Windows 11 24H2. #402 #405

Added new option "Enable Win7 style titlebar button glow" (CustomBlur method only) #23
Added new option "Disable the effect in power-saving mode" which allows you to enable DWMBlurGlass even in power saving mode.
Added new option "Enable blur rendering optimization" If Rendering Optimization is enabled, 
it will reduce the quality of the system blurring effect as well as the kernel size to reduce GPU usage, but the quality of the blurring will be degraded.  #200 #243 #343
Added an exception dump function, if dwm crashes, a dump file will be generated in the "data\dumps" directory Provide it to us when reporting 
bugs so that developers can analyze and solve the problem.
Migrated the GUI from MiaoUI Core to the open source MiaoUI Lite Now you can freely compile complete projects including the GUI.

Optimized and fixed surface culling optimization for Windows 10 On by default.

Fixed the bug that modifying HEX color value in GUI does not take effect. #307
Fixed the bug that Aero reflections are truncated on multiple monitors. #136 #241 #280
Fixed issue with RTL text mirroring. #138
Fixed abnormal rendering of some apps. #219 #268 #320
Fixed the bug that "Override AccentBlur effect" causes the background of some apps to be transparent and incorrectly colored. #285 #289 #304 #329 #338
Fixed the bug that "Use Accent color to override color settings RGB" did not work correctly after reboot. #299
Fixed the bug that restarting the dwm process did not properly follow the system transparency effect and power saving mode options. #301

Stability improvement and optimization.  #296 #346 #390

Translation Updates.
Thanks (in order of last submission):
Russian(ru-Ru) - @shikulja
Spanish (es-ES) - @xoascf
Turkish (tr-TR) - @baglayan
Italian (it-IT) - @LuisYeah1234-hub
Korean (ko-KR) - @Longhorn004
Trad.Chinese (zh-TW) - @railyinu
Vietnamese (vi-VN) - @reggyxt
German (de-DE) - @akaydev-coder
Japanese (ja-JP) - @reshP-0325

2.2.0 - 2024-4-26
增加了新AeroBackdrop的GUI设置选项 #234
增加了动画效果开关，以及动画效果时长的设置选项 #96
增加了覆盖Accent模糊效果的选项
增加了使用系统主题色覆盖DWMBlurGlass的RGB颜色的选项 #86
增加了Aero反射纹理不透明度的可调整选项
增加了节电模式效果，如果系统处于节电模式将自动禁用模糊效果 #261
增加了RDP远程桌面模式下的效果支持，以及dwm崩溃自动重载功能(并具有异常检查) #160 #40

GUI颜色选择器中增加了HEX颜色值编辑框 #173
CustomBlur适应了系统设置-个性化-颜色中的"透明效果"开关，可以通过系统设置关闭或开启模糊效果 #152

修复了重启计算机后概率无法加载的bug #149 #161
修复了Windows10选择Mica之后崩溃的bug #244
优化了AeroBackdrop的效果，感谢 @kfh83

将"减少标题栏按钮高度 (win7样式)"更名为"还原win7样式标题栏按钮尺寸" 并优化了按钮偏移量和尺寸以及计算方法
现在标题栏按钮样式将1:1还原win7的尺寸

如果自动计算的偏移量不正确 或您想自定义偏移量 现在可以通过config.ini添加"titlebtnOffsetX"来修改X偏移位置
默认值 -1 为自动计算 大于-1将使用目标的值
[config]
titlebtnOffsetX=-1

#

Added GUI setting options for the new AeroBackdrop. #234
Added an animation effect switch, and an option to set the duration of the animation effect. #86
Added option to override Accent blur effect.
Added option to use system theme color to override the RGB color of DWMBlurGlass. #86
Added adjustable options for Aero reflection texture opacity.
Added power saving mode effect, which will automatically disable the blur effect if the system is in power saving mode. #261
Added support for effects in RDP remote desktop mode, as well as automatic overloading of dwm crashes (with exception checking).

The GUI color selector has added a HEX color value editing box. #173
CustomimBlur adapts to the "Transparent Effect" switch in "System Settings - Personalization - Colors", which can be turned off or on through the system settings. #152

Fixed a bug where the probability of not being able to load after restarting the computer. #149 #161
Fixed a bug in Windows 10 that crashed after selecting Mica. #244
Optimized the effect of AeroBackdrop, thank you @kfh83.

Renamed "Reduce Title Bar Button Height (Win7 Style)" to "Restore Win7 style title bar button size" and optimized button offset, size, and calculation method.
The title bar button style will now be 1:1 pixels back to Windows 7 size.
If the automatically calculated offset is not correct or you want to customize the offset you can now change the X offset by adding "titlelebtnOffsetX" to config.ini.
Default value -1 is calculated automatically. Greater than -1 the value of the target will be used.
[config]
titlebtnOffsetX=-1

2.1.1 - 2024-3-30
Update de-DE.xml by @akaydev-coder in #150
update translate for Chinese Trad. by @railyinu in #169
sv-SE.xml Updated by @Vinyx08 in #210
Aero backdrop accuracy changes by @kfh83 in #222
Feature updates and bug fixes by @ALTaleX531 in #227
Fix ColorBalance in config.ini being ineffective by @kfh83 in #232
Invert X-direction scaling of parallax effect by @xoascf in #235
Force UTF-8 encoding compilation by @xoascf in #236
Fix round corner and other crashing issues by @ALTaleX531 in #238

2.1.0 - 2024-3-27
Traditional Chinese by @railyinu in #145
Update de-DE.xml by @akaydev-coder in #150
update translate for Chinese Trad. by @railyinu in #169
sv-SE.xml Updated by @Vinyx08 in #210
Aero backdrop accuracy changes by @kfh83 in #222
Feature updates and bug fixes by @ALTaleX531 in #227

Fixed #220.
Fixed #141.
Fixed #133.
Fixed #97.
Optimized the display of glass reflection. #136
Optimized graphics performance. #200
Optimized configuration refresh response speed and behavior.
Removed the annoying install/uninstall message box

2.0.1 - 2024-2-7
小更新，主要是bug修复

修复了部分窗口拖拽延迟的问题
修复了部分窗口文本被裁剪的问题
修复了关闭窗口动画边框超出的问题
修复了启用自定义效果且未扩展边框时，窗口边框线颜色不显示的问题
优化了和修复了GUI程序的一些文本布局和体验

增加了韩语翻译
感谢: Longhorn004

Minor update, mainly bug fixes.

Fixed the issue of delayed dragging in some windows.
Fixed the issue of text cropping in some windows.
Fixed the issue that the border was expanded during the closing window animation.
Fixed the issue that the border line disappears when using aero theme without "Extend effect to border" option enabled.
Optimized and fixed some text layout and experience of GUI program.

Added Korean translation
Thanks to: Longhorn004

2.0.0 - 2024-2-6
重大更新
增加了我们编写的自定义模糊类，用于代替DWM的旧内部模糊，实现高性能、高自定义度且令人惊叹的视觉效果，特别感谢ALTaleX的一系列研究和实现。
之前版本的诸多的问题都是由于DWM内部的旧模糊类引起的，因此 全新的自定义模糊类将解决所有旧模糊类的问题，这里不在详细列出请自行体验!
修改选项"模糊半径(全局)" 为可选项 可自行选则是否修改全局模糊半径
增加了 亮/暗 颜色模式可以单独配置颜色 自适应系统亮暗颜色主题变化
增加了页面"高级":
 新增模糊方法选项: 现在可在 自定义模糊、旧模糊、DWMAPI三种方法之间自由切换
  自定义模糊 - 可选Blur、Aero、Acrylic、Mica效果 可以自定义绝大部分参数
  旧模糊 - 仅Blur效果 (是1.0.4以及之前版本的DWMBlurGlass的模糊方法) 可以自定义部分参数
  DWMAPI - 使用Window 11的DwmSetWindowAttribute API设置SystemBackdrop效果 可选 Mica、Acrylic、MicaAlt 不可自定义参数

 参数设置: 
  标题栏模糊半径(仅限自定义模糊方法): 如果未勾选修改全局模糊半径 则可以在此处修改仅标题栏的模糊半径
  材质亮度透明度(仅限自定义模糊方法): 自定义Acrylic/Mica效果的luminosityOpacity参数
 
Aero反射效果 现在支持Windows 11(仅限自定义模糊方法)
优化了Aero反射效果，加入了视差效果(仅限自定义模糊方法)
增加了窗口激活和失去焦点之间的过渡动画 使颜色过渡更加优雅!(仅限自定义模糊方法)
优化了窗口最大化/最小化动画表现(仅限自定义模糊方法)

修复了选项"减少标题栏按钮高度 (win7样式)" 在默认主题下和部分不支持DPI缩放的老程序下布局外观异常的问题
修复了配置文件从外部导入后没有立即生效的问题
修复了Windows11 21H2崩溃的问题
优化了旧模糊方法的性能，但我们推荐您使用我们的新自定义模糊方法，它的效率是旧模糊的至少10倍以上!
优化了DWMBlurGlass GUI的部分元素和高DPI显示效果以及部分控件自适应语言文本长度
优化了卸载时系统外观恢复的表现

优化了英文翻译
感谢：ALTaleX

效果的介绍请参见ReadMe.md
我们期待您的反馈!

Major Updates
Added our own custom blur implementation to replace DWM's old internal blur for high performance, better customization and gorgeous visual effects, special thanks to ALTaleX for a series of research and implementation.
Most of the problems in the previous version were caused by the old DWM internal blur class, so the new custom blur class will solve all the problems of the old one, which will not be listed here in detail, so please try it out for yourself!
Modify the option "Blur radius (global)" to optional, you can choose whether to modify the global blur radius or not.
Added Light/Dark color mode to configure the color individually to adapt to the system's light/dark color theme.
Added page "Advanced".
 New Blur Method option: You can now switch between Custom Blur, Legacy Blur, and DWMAPI methods.
  Custom Blur - Blur, Aero, Acrylic, Mica effects are available. Most of the parameters can be customized.
  Legacy Blur - Blur effect only (blur method of DWMBlurGlass from 1.0.4 and earlier). You can customize some of the parameters.
  DWMAPI - use Window 11's api DwmSetWindowAttribute to apply SystemBackdrop effect, you can choose Mica, Acrylic, MicaAlt. But parameters cannot be customized.

 Parameter Settings. 
  TitleBar Blur Radius (custom blur method only): If the option "Blur radius (global)" is unchecked, you can modify the blur radius of the titlebar here.
  Luminosity Opacity (custom blur method only): Customize the luminosityOpacity parameter for Acrylic/Mica effects.
 
Aero reflection effect now supports Windows 11 (custom blur methods only).
Optimized Aero Reflections to include parallax effect (custom blur methods only)
Added transition animation between window activation and loss of focus Makes color transitions more elegant! (Custom blur method only)
Optimized window maximize/minimize animation performance (custom blur method only)

Fixed the issue that the option "Decrease titlebar button height (win7 style)" layout looks abnormal under the default theme and some old programs that don't support DPI scaling.
Fixed the problem that the configuration file did not take effect immediately after importing from an external place.
Fixed Windows 11 21H2 crash issue.
Optimized the performance of the old blur method, but we recommend you to use our new custom blur implementation which is at least 10 times more efficient than the old one!
Optimized some elements of DWMBlurGlass GUI and high DPI appearance as well as adaptive language text length of some controls
Optimized the performance of system appearance recovery during uninstallation

Optimized English translation
Thanks to: ALTaleX 

See ReadMe.md. for a description of the effect.
We are looking forward to your feedback!

1.0.4 - 2024-2-1
优化了程序稳定性
修复了Windows11 部分程序Mica背景变为纯色的问题
优化了"减少标题栏按钮高度 (win7样式)"的样式 现在应当1:1还原win7的宽高 并修复了Tool窗口按钮尺寸不正确的问题
修复了GUI程序关闭后有概率在后台死锁导致无法再次打开的问题
内置增加了Windows 11 23H2 22631.3085的符号

增加了日语、俄语、土耳其语、法语、葡萄牙语、印尼语、意大利语等翻译
感谢: Baakun, real-squid-kid, Dekamir, Unbloated, ghost, naturbrilian, LuisYeah1234-hub

Optimized program stability.
Fixed the problem that Mica background changed to solid color in some programs of Windows 11.
Optimized the style of "Reduce title bar button height (win7 style)" Now it should be 1:1 Win7 width and fix the problem of incorrect size of Tool window buttons.
Fixed the problem that the GUI program may be deadlocked in the background after closing and cannot be opened again.
Built-in added symbols for Windows 11 23H2 22631.3085.

Added Japanese, Russian, Turkish, French, Portuguese, Indonesian and Italian translations.

Thanks to Baakun, real-squid-kid, Dekamir, Unbloated, ghost, naturbrilian, LuisYeah1234-hub

1.0.3 - 2024-1-21
修复Aero反光效果可能在部分窗口截断的问题
修复了活动窗口颜色透明度使用的是非活动窗口透明度的问题
修复了窗口混合色的圆角裁剪的问题
优化了"减少标题栏按钮高度 (win7样式)"的样式 使其更接近win7样式
优化了稳定性和效率
追加修复Windows 11 部分效果失效的问题 (2024-1-21 4:23)

增加了德语翻译 感谢akaydev-coder

Fix the problem that Aero reflection effect may be truncated in some windows.
Fix the problem that the active window color transparency uses the inactive window transparency.
Fixed the problem of rounded corner cropping for window color mixing.
Optimized the style of "Reduce title bar button height (win7 style)" to be closer to the Win7 style.
Optimized stability and efficiency.

Additional fixes for Windows 11 effect failure.(2024-1-21 4:23)

Added German translation Thanks to @akaydev-coder.

1.0.2 - 2024-1-20
增加新的选项"减少标题栏按钮高度 (win7样式)" 启用此选项将减少标题栏按钮的高度 看起来和win7样式差不多
增加支持单独设置活动窗口和非活动窗口的混合颜色
修复了Aero反光效果多显示器呈现不正确的问题
优化了使用第三方主题的发光字效果
支持为使用旧版win7API: DwmEnableBlurBehindWindow 的程序启用模糊效果

增加西班牙语翻译 感谢arukateru

Add new option "Reduce title bar button height (win7 style)" Enable this option to reduce the height of title bar buttons, it looks similar to Win7 style.
Add support for setting separate color mixing for active and inactive windows.
Fixed the problem that Aero reflections are rendered incorrectly on multiple monitors.
Optimized the effect of illuminated characters when using third-party themes
Support for enabling blur effect for programs using the old win7 API: DwmEnableBlurBehindWindow.

Add Spanish translation Thanks to @arukateru

2024-1-17
增加新的选项"扩展效果到边框 (win10)" 由于win10主题的特殊性 此选项是为了兼容第三方主题 而win11没有这个问题
增加新的选项"启用Aero反光效果 (win10)" 这将启用win7的aero反射底图效果 目前仅支持win10
适配了第三方主题的发光字效果 如果第三方主题支持发光字 则会显示发光字效果

Add new option "Extend effects to borders (win10)" Due to win10 theme specificity this option is for compatibility with third party themes while win11 doesn't have this problem.

Add new option "Enable Aero Reflections (win10)" This will enable win7's aero reflective underlay effect currently only supported in win10.

Adapted third-party theme's light-emitting character effect If the third-party theme supports light-emitting characters, the light-emitting character effect will be displayed.