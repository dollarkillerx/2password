import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:password2/widget/input.dart';
import 'controller.dart';

class AboutPage extends GetView<AboutController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AboutController>(
        builder: (controller) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Center(
                    child: Text(controller.pass,style: TextStyle(fontSize: 20),),
                  ),
                  width: 350,
                ),
                SizedBox(height: 10,),
                LoginButton("重新生成密码",onPressed: (){
                  controller.flashData();
                },),
                SizedBox(height: 10,),
                LoginButton("复制密码",onPressed: (){
                  Clipboard.setData(
                      ClipboardData(text: controller.pass));
                },),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text("长度: ${controller.value.toInt()}"),
                    Expanded(child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 1, // 轨道高度
                        trackShape: RectangularSliderTrackShape(), // 轨道形状，可以自定义
                        activeTrackColor: Colors.blueGrey, // 激活的轨道颜色
                        inactiveTrackColor: Colors.black26,  // 未激活的轨道颜色
                        thumbShape: RoundSliderThumbShape( //  滑块形状，可以自定义
                            enabledThumbRadius: 10  // 滑块大小
                        ),
                        thumbColor: Colors.white, // 滑块颜色
                        overlayShape: RoundSliderOverlayShape(  // 滑块外圈形状，可以自定义
                          overlayRadius: 20, // 滑块外圈大小
                        ),
                        overlayColor: Colors.black54, // 滑块外圈颜色
                        valueIndicatorShape: PaddleSliderValueIndicatorShape(), // 标签形状，可以自定义
                        activeTickMarkColor: Colors.red,  // 激活的刻度颜色
                      ),
                      child: Slider(
                        value: controller.value,
                        min: 4,
                        max: 40,
                        divisions: 40,
                        label: '${controller.value}',
                        onChanged: (v){
                          controller.setValue(v);
                          controller.flashData();
                        },
                      ),
                    ))
                  ],
                ),
                SizedBox(height: 10,),
                BrnSwitchFormItem(
                  title: "A-Z",
                  value: controller.uppercaseLetter,
                  onChanged: (oldValue, newValue) {
                    controller.modifyUppercaseLetter(newValue);
                    controller.flashData();
                  },
                ),
                SizedBox(height: 10,),
                BrnSwitchFormItem(
                  title: "a-z",
                  value: controller.lowerCaseLetters,
                  onChanged: (oldValue, newValue) {
                    controller.modifyLowerCaseLetters(newValue);
                    controller.flashData();
                  },
                ),
                SizedBox(height: 10,),
                BrnSwitchFormItem(
                  title: "0-9",
                  value: controller.number,
                  onChanged: (oldValue, newValue) {
                    // controller.modifyNumber(newValue);
                  },
                ),
                SizedBox(height: 10,),
                BrnSwitchFormItem(
                  title: "!@#%^&*",
                  value: controller.specialCharacters,
                  onChanged: (oldValue, newValue) {
                    controller.modifySpecialCharacters(newValue);
                    controller.flashData();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
