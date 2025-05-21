import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trreu/views/colors.dart';

Widget commonText(
  String text, {
  double size = 12.0,
  Color color = Colors.black,
  bool isBold = false,
  bool islogoText = false,
  bool softwarp = true,

  bool haveUnderline = false,
  fontWeight,
  TextAlign textAlign = TextAlign.left,
}) {
  return Text(
    text,
    softWrap: softwarp,
    textAlign: textAlign,

    style:
        (islogoText)
            ? GoogleFonts.almendra(
              fontSize: size,

              color: color,

              fontWeight:
                  isBold
                      ? FontWeight.bold
                      : (fontWeight != null)
                      ? fontWeight
                      : FontWeight.normal,
            )
            : GoogleFonts.openSans(
              fontSize: size,
              color: color,
              fontWeight:
                  isBold
                      ? FontWeight.bold
                      : (fontWeight != null)
                      ? fontWeight
                      : FontWeight.normal,
            ),
  );
}

Widget commonTextfield(
  TextEditingController controller, {
  FocusNode? focusNode,
  String hintText = "",
  bool isBold = true,
  bool issuffixIconVisible = false,
  bool isPasswordVisible = false,
  enable,
  prefixIcon,
  textSize = 14.0,
  Color? color,
  suffixIcon,
  double? height,
  hintcolor = AppColors.black,
  borderWidth = 1.0,
  optional = false,
  changePasswordVisibility,
  TextInputType keyboardType = TextInputType.text,
  String? assetIconPath,
  Color borderColor = AppColors.black,
  int maxLine = 1,
  String? Function(String?)? onValidate,
  Function(String?)? onFieldSubmit,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: TextFormField(
            controller: controller,
            enabled: enable,
            focusNode: focusNode,
            validator: onValidate,
            onFieldSubmitted: onFieldSubmit,
            keyboardType: keyboardType,
            style: TextStyle(color: hintcolor),
            maxLines: maxLine,
            obscureText: isPasswordVisible,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(12.0),
              hintText: hintText,
              fillColor: color,
              filled: color != null,
              hintStyle: TextStyle(fontSize: 14, color: hintcolor),
              border: InputBorder.none,
              suffixIcon:
                  (issuffixIconVisible)
                      ? (!isPasswordVisible)
                          ? InkWell(
                            onTap: changePasswordVisibility,
                            child: Icon(Icons.visibility),
                          )
                          : InkWell(
                            onTap: changePasswordVisibility,
                            child: Icon(Icons.visibility_off_outlined),
                          )
                      : suffixIcon,
              prefixIcon:
                  assetIconPath != null
                      ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ImageIcon(AssetImage(assetIconPath), size: 24.0),
                      )
                      : prefixIcon,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget commonButton(
  String title, {
  Color color = AppColors.buttonColor,
  Color textColor = Colors.white,
  double textSize = 18,
  double width = double.infinity,
  double height = 50,
  VoidCallback? onTap,
  TextAlign textalign = TextAlign.left,
  bool isLoading = false,
  bool haveNextIcon = false,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: color,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child:
              isLoading
                  ? const CircularProgressIndicator()
                  : FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        commonText(
                          textAlign: textalign,
                          title,
                          size: textSize,
                          color: textColor,
                          isBold: true,
                        ),
                        if (haveNextIcon)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Image.asset("assets/arrow.png"),
                          ),
                      ],
                    ),
                  ),
        ),
      ),
    ),
  );
}

Widget buildOTPTextField(
  TextEditingController controller,
  int index,
  BuildContext context,
) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.buttonColor,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 6,
          offset: const Offset(-3, 0),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 6,
          offset: const Offset(3, 0),
        ),
      ],
    ),
    width: 45,
    height: 45,
    child: TextField(
      controller: controller,

      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      cursorColor: Colors.black,
      style: const TextStyle(
        fontSize: 20,
        color: AppColors.white,
        fontWeight: FontWeight.bold,
      ),
      maxLength: 1,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0),
        counterText: '',
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: (value) {
        if (value.length == 1 && index < 5) {
          FocusScope.of(context).nextFocus();
        } else if (value.isEmpty && index > 0) {
          FocusScope.of(context).previousFocus();
        }
      },
    ),
  );
}

AppBar commonAppBar(
  String title, {
  haveBackButton = true,
  Color? color,
  Color textcolor = Colors.black,
}) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    backgroundColor: color,
    title: commonText(title, size: 18, isBold: true, color: textcolor),
    leading: (haveBackButton) ? BackButton() : null,
  );
}

void commonSnackbar({
  required String title,
  required String message,
  SnackPosition position = SnackPosition.BOTTOM,
  Color backgroundColor = Colors.black87,
  Color textColor = Colors.white,
  Duration duration = const Duration(seconds: 3),
  double margin = 12.0,
  double borderRadius = 8.0,
  SnackStyle snackStyle = SnackStyle.FLOATING,
}) {
  Get.snackbar(
    title,
    message,
    snackPosition: position,
    backgroundColor: backgroundColor,
    colorText: textColor,
    duration: duration,
    margin: EdgeInsets.all(margin),
    borderRadius: borderRadius,
    snackStyle: snackStyle,
  );
}
