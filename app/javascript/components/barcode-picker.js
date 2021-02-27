const pickUpBarcode = () => {
  ScanditSDK.configure("ATUfLTE5EWCmKPbTnhBV3Tc6t886KGobO399q8Fv7yQjWdPU+liVYPhzuwm7P36TNXKu4mAhUcHgZER3DyNQcil/697rdGrVdEls3JRRmrYoScb65lCCwWQ61IExNXG/qCL43JQ0gSYcUYyj3W6CIWwWgg03zPbsGlv1hK2eefaxqDJgsJaQWPVRkWwKr2odGHzczMjzSB6EwCVmLJIdMno7BNm85GYUVPPyiCdonMtwLlpIl5b7P6x7jLR+AQKR4fFKgIoSVdsak6nS2Eo0ra1dIQfqPmr/SKHhrs3dWnCU6E5tLkySVVDAacoTvPjQ6s8NeHQ/7036MwkGx8Eylpn1UnEB3Mby+dUc9jUiQ0DUBaYd2VYyS8sLYLlVW4zM889IZfu+TZg2ASjpvBOZvqIEEPta7cdlkF+9qQUQK5U5vGOS1tlToG+djCGwjgDnVCQ0sQ+hlyvO/zvrQP1qR8km0GZBR8WB/0U1cSrWjoQJ9RAT6FiNsP/9WR87JXOQ7ost2M7/LVHbl7y6v3V1tdiJK1tNousz3xT1umfAa+gcBKtrDOST1dVEO632+WZgBlevqB0DfOrK7/dc5MMoHJj8NC875yvRFez2rvsjZwjRXTxo23EG5jii3fFEyCpL4DwtUGuY2TFYpqwZh1DMBJMX9Ea3rDMTRjHDlxaH52hrd1oSNW+1FVloIbHkHKYkOC3FOveBN2vTHmpW7MiGD0qs+7svJEUvzJr/AOoLq0KwBi8knDQqnkTcyw8CT2lfI85YVJQySYjpXYgr9q3mDpgcGeeD8Pm98GvyWoflk0ttJ50JZhU=", {
    engineLocation: "https://cdn.jsdelivr.net/npm/scandit-sdk/build",
  }).then(() => {
    ScanditSDK.BarcodePicker.create(document.getElementById("scandit-barcode-picker"), {
      playSoundOnScan: true,
      vibrateOnScan: true,
    }).then(function (barcodePicker) {
      let scanSettings = new ScanditSDK.ScanSettings({
        enabledSymbologies: ["ean8", "ean13", "upca", "upce", "code128", "code39", "code93", "itf"],
        codeDuplicateFilter: 1000,
      });
      barcodePicker.applyScanSettings(scanSettings);
      barcodePicker.on("scan", function (scanResult) {
        document.getElementById('upc').value = scanResult.barcodes[0].data;
        document.getElementById('barcode-form').submit()
      });
    });
  });
}

export { pickUpBarcode };
