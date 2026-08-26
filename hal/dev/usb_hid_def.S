; File: Hal/HAL_USB_HID_DEF.S
; Description: USB HID Definitions for AVR-DU family.

; customs
#define USB_HID_REPORT_DESCRIPTOR_SIZE                63 // Human Interface Devices (HID) report descriptor size

; Standard
#define HID_SUB_CLASS_NOBOOT                        0x00 // No Boot subclass
#define HID_SUB_CLASS_BOOT                          0x01 // Boot subclass

#define HID_PROTOCOL_GENERIC                        0x00 // Used for devices that do not implement a specific HID class
#define HID_PROTOCOL_KEYBOARD                       0x01 // Used for keyboards
#define HID_PROTOCOL_MOUSE                          0x02 // Used for mice

#define USB_REQ_HID_GET_REPORT                      0x01 // Request to get the current report from the HID device
#define USB_REQ_HID_GET_IDLE                        0x02 // Request to get the current idle rate for a particular HID report
#define USB_REQ_HID_GET_PROTOCOL                    0x03 // Request to get the current protocol in use by the HID device
#define USB_REQ_HID_SET_REPORT                      0x09 // Request to send a report to the HID device
#define USB_REQ_HID_SET_IDLE                        0x0A // Request to set the idle rate for a particular HID report
#define USB_REQ_HID_SET_PROTOCOL                    0x0B // Request to set the protocol to be used by the HID device

#define USB_DT_HID                                  0x21 // Descriptor type for HID class. Used to describe HID device information such as country code and HID class specification release.
#define USB_DT_HID_REPORT                           0x22 // Descriptor type for HID report. Used to define the data format and the controls used by the HID device.
#define USB_DT_HID_PHYSICAL                         0x23 // Descriptor type for HID physical descriptors (optional). Used to describe the physical characteristics of a device.

#define USB_HID_ITEM_REPORT_TYPE_MAIN               0x00 // Main items are used to define the data fields in HID reports, such as Input, Output and Feature reports
#define USB_HID_ITEM_REPORT_TYPE_GLOBAL             0x01 // Global items apply to all the subsequent items in the report descriptor and define characteristics such as usage page, logical minimum, logical maximum, etc
#define USB_HID_ITEM_REPORT_TYPE_LOCAL              0x02 // Local items define characteristics that are specific to a particular item, such as usage or designator index
#define USB_HID_ITEM_REPORT_TYPE_LONG               0x03 // Long items are not commonly used but are available for future expansion and allow for extended data fields that are not defined by the standard HID item types

#define USB_HID_REPORT_TYPE_INPUT                   0x01 // Input reports are sent by the HID device to the host to report the state of the input controls
#define USB_HID_REPORT_TYPE_OUTPUT                  0x02 // Output reports are sent by the host to the HID device to control the state of the output controls
#define USB_HID_REPORT_TYPE_FEATURE                 0x03 // Feature reports are used to exchange feature data between the host and the HID device that may not be directly tied to input or output, such as configuration data

#define USB_HID_PROTOCOL_BOOT                       0x00 // Boot protocol is a simplified protocol that supports a limited set of HID devices
#define USB_HID_PROTOCOL_REPORT                     0x01 // Report protocol provides a more complex and feature-rich means of communication between the HID device and the host

#define USB_HID_BCD_V1_11                           0x0111 // HID class specification release number in BCD (Binary-Coded Decimal) format
#define USB_HID_NUM_DESC                            0x01 // Number of HID class descriptors

#define USB_HID_NO_COUNTRY_CODE                     0x00 // Not Supported
#define USB_HID_COUNTRY_ARABIC                      0x01 // Arabic
#define USB_HID_COUNTRY_BELGIAN                     0x02 // Belgian
#define USB_HID_COUNTRY_CANADIAN_BILINGUAL          0x03 // Canadian-Bilingual
#define USB_HID_COUNTRY_CANADIAN_FRENCH             0x04 // Canadian-French
#define USB_HID_COUNTRY_CZECH_REPUBLIC              0x05 // Czech Republic
#define USB_HID_COUNTRY_DANISH                      0x06 // Danish
#define USB_HID_COUNTRY_FINNISH                     0x07 // Finnish
#define USB_HID_COUNTRY_FRENCH                      0x08 // French
#define USB_HID_COUNTRY_GERMAN                      0x09 // German
#define USB_HID_COUNTRY_GREEK                       0x0A // Greek
#define USB_HID_COUNTRY_HEBREW                      0x0B // Hebrew
#define USB_HID_COUNTRY_HUNGARY                     0x0C // Hungary
#define USB_HID_COUNTRY_INTERNATIONAL_ISO           0x0D // International (ISO)
#define USB_HID_COUNTRY_ITALIAN                     0x0E // Italian
#define USB_HID_COUNTRY_JAPAN_KATAKANA              0x0F // Japan (Katakana)
#define USB_HID_COUNTRY_KOREAN                      0x10 // Korean
#define USB_HID_COUNTRY_LATIN_AMERICAN              0x11 // Latin American
#define USB_HID_COUNTRY_NETHERLANDS_DUTCH           0x12 // Netherlands/Dutch
#define USB_HID_COUNTRY_NORWEGIAN                   0x13 // Norwegian
#define USB_HID_COUNTRY_PERSIAN_FARSI               0x14 // Persian (Farsi)
#define USB_HID_COUNTRY_POLAND                      0x15 // Poland
#define USB_HID_COUNTRY_PORTUGUESE                  0x16 // Portuguese
#define USB_HID_COUNTRY_RUSSIA                      0x17 // Russia
#define USB_HID_COUNTRY_SLOVAKIA                    0x18 // Slovakia
#define USB_HID_COUNTRY_SPANISH                     0x19 // Spanish
#define USB_HID_COUNTRY_SWEDISH                     0x1A // Swedish
#define USB_HID_COUNTRY_SWISS_FRENCH                0x1B // Swiss/French
#define USB_HID_COUNTRY_SWISS_GERMAN                0x1C // Swiss/German
#define USB_HID_COUNTRY_SWITZERLAND                 0x1D // Switzerland
#define USB_HID_COUNTRY_TAIWAN                      0x1E // Taiwan
#define USB_HID_COUNTRY_TURKISH_Q                   0x1F // Turkish-Q
#define USB_HID_COUNTRY_UK                          0x20 // UK
#define USB_HID_COUNTRY_US                          0x21 // US
#define USB_HID_COUNTRY_YUGOSLAVIA                  0x22 // Yugoslavia
#define USB_HID_COUNTRY_TURKISH_F                   0x23 // Turkish-F