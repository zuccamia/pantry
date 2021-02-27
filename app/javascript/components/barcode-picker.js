const pickUpBarcode = () => {
  ScanditSDK.configure("AQBvviM5A3N+AW7EyhcBwvM1s1vGJrbAGV9fe6hc5lRCaSIQR0S4vTNBQKOlM9QsrGuNomZd9oZhc9irR18+7R5Fe6oQV/E9q1ojYs9o4/eecfOlRE8Vv+hAIu2MUoawun/U9pRZMm8xKaFDhB7URpMT0yx0E+hdDCK7pobyFLDEA9NNV6Bq8G+hMHD2M9eR4b6K1+Dr6TyQRjPE9cYsaN2yP4+UUmce5NPWf98fis56vKCqom72pgZ4ncaNx7jWwSyyf7oUbx5Qq/LRt8tlPLJP14ZJI07C9DiO19MU5QlAKirV71DrsYYq2BJNnL/KhtFVBg+fzUKrsuY6vvFeosPzb3cjfC/GzvOWMfYBE3orEWWvC2Ya0YVBg9HMA4sq40cX9Saie75bd+mFe11Snnb3pZ8s8MH1nL85nLsBgUoCC9d3o53rc46p/jL5pcEVioxbtWgrmCOcv010LDD1as14xt+m123i0zPvcOuVAaTF3Ar0JPhpCRFOJaJzRoRvjDsQxYf95I4Lc+u4auAEmLifA2uHrhbNBXln1pgqpJLgppT2boH+GSROWaDC4u8MirRn/IUL8Y2SBVY0b0HweXWVaxZv5P4MUauP1t7NiUstzMXNnAAuVM9E78ojx29oAg7WqpDWeTg4ymSXfYE8mLbmoC6RwcoJA9xaKyQTRPWKq2FkWGYWfpcRyrQQ2qm5a6r3lIgvsxtnqZamXqXRuZ6uIz3dsg0o8fceaUIeu6EVnK13o8WRf4Xyn3FX+bQR+5BwQQx+N80uM3L6tMPP2KCsV8xnl1Hu59hKncVtRhPx/oGodEWcZBKanE4CCKHBn+9neicP", {
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
