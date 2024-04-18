// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:vc_product_widgets/helper/loading_spinner/vc_loading_spinner.dart';
import 'package:vc_product_widgets/helper/modal_popup/modal_popup_helper.dart';
import 'package:vc_product_widgets/utils/device_utils.dart';

class SecurityCheckExamples {
  static Future<void> securityChecksWidget(BuildContext context) async {
    VCLoadingSpinner.show();
    bool? isJailBroken = await DeviceUtils.instance.isJailBroken();
    bool? isRealDevice = await DeviceUtils.instance.isRealDevice();
    bool? canMockLocation = await DeviceUtils.instance.canMockLocation();
    bool? isOnExternalStorage =
        await DeviceUtils.instance.isOnExternalStorage();
    bool? isSafeDevice = await DeviceUtils.instance.isSafeDevice();
    bool? isDevelopmentModeEnable =
        await DeviceUtils.instance.isDevelopmentModeEnable();
    VCLoadingSpinner.dismiss();
    ModalPopupHelper.instance.showWidgetModal(
        context,
        DataTable(
          columns: const [
            DataColumn(label: Text('Property')),
            DataColumn(label: Text('Value')),
          ],
          rows: [
            DataRow(cells: [
              const DataCell(Text('Jail Broken')),
              DataCell(
                  Text(isJailBroken != null ? isJailBroken.toString() : 'N/A')),
            ]),
            DataRow(cells: [
              const DataCell(Text('Real Device')),
              DataCell(
                  Text(isRealDevice != null ? isRealDevice.toString() : 'N/A')),
            ]),
            DataRow(cells: [
              const DataCell(Text('Mock Location')),
              DataCell(Text(canMockLocation != null
                  ? canMockLocation.toString()
                  : 'N/A')),
            ]),
            DataRow(cells: [
              const DataCell(Text('On External Storage')),
              DataCell(Text(isOnExternalStorage != null
                  ? isOnExternalStorage.toString()
                  : 'N/A')),
            ]),
            DataRow(cells: [
              const DataCell(Text('Safe Device')),
              DataCell(
                  Text(isSafeDevice != null ? isSafeDevice.toString() : 'N/A')),
            ]),
            DataRow(cells: [
              const DataCell(Text('Development Mode')),
              DataCell(Text(isDevelopmentModeEnable != null
                  ? isDevelopmentModeEnable.toString()
                  : 'N/A')),
            ]),
          ],
        ),
        hasCloseButton: true,
        minHeight: 100);
  }
}
