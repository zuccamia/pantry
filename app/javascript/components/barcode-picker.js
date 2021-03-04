const pickUpBarcode = () => {
  ScanditSDK.configure("Aclf+Bo5OpT/Dx8+hjAdWhARENDRBdFqE38lrRB1nliRW/Fb51so87dcxCXGA2wkLVq9HhNRq03DK/aa2XlCfbR8X9HkddsqMRdJ7t1wvsRMVSFe/V/wnW5gddcnNSf6x0X3G7VE5IuuBz4+H/6zXJBxliMX8dr0yUursfz4Y17HjYZkY0GCUhIR2t7fgOGTGL5R+bvZOglzUsEnDJkxLqFwIlcfg2WuAGv6ni+JNscXfl2seBUi/f5O++gH9q5V0Ev8UktgUxeT1+RkBTZ8rVhbooFcM4qEC8SVH6KhPn72Pv15NLu6C99NvjO0ZaenxEbqfhGwqQ7C2FA5rIOqKwYsdqiwVUQjnuRpPQ/JgoZGuh2Zcwr/8Sp64yyyCcEgZbJEFABf5BMMgOcJdzAF7coQp+xCVQWPLggLZ21ne2JDJGUOFxl7VsZkD7Pxfme+un2RUovcHwTRugwmFEv403HAbyyPhR7pTCiHndRv8cCI/oW8equ/pHGTRwGszO/FPd4daM+jObqqaeh08aEylLlSrPoRNP4egcEK2spT9fUaT9L359JNnvod7YH5B6gZBbnhWLS4r7hu5+imkUpxt3G7SsDWwvBka2Mt8/vfWZ6FNMNjQa2PJAR5YUtKkGhoo72kXxEzBljFRqBAiJG9WP5z3HFXRFf5Hp7u1wRo2VsP/FjAZo4BT2TMilYv1GhfWzk7oX6RwFFs4EWPfEwrJmFkAMfdXc9sal8lfUUH76qF1ysY9aDtMAthG7hWHnJ1yCnmnI3K4E/HbM8uuMNUaxv3PZZeRW8bOyQ/NDK8eayM2r2UE9Gs/oI2BQ==", {
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
