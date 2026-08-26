; USB Human Interface Device (HID) protocol definitions
;

#define HID_SUB_CLASS_NOBOOT 0x00
#define HID_SUB_CLASS_BOOT 0x01

#define HID_PROTOCOL_GENERIC 0x00
#define HID_PROTOCOL_KEYBOARD 0x01
#define HID_PROTOCOL_MOUSE 0x02
#define USB_REQ_HID_GET_REPORT = 0x01, /**< Request to get the current report from the HID device*/
#define USB_REQ_HID_GET_IDLE = 0x02, /**< Request to get the current idle rate for a particular HID report*/
#define USB_REQ_HID_GET_PROTOCOL = 0x03, /**< Request to get the current protocol in use by the HID device*/
#define USB_REQ_HID_SET_REPORT = 0x09, /**< Request to send a report to the HID device*/
#define USB_REQ_HID_SET_IDLE = 0x0A, /**< Request to set the idle rate for a particular HID report*/
#define USB_REQ_HID_SET_PROTOCOL = 0x0B, /**< Request to set the protocol to be used by the HID device*/

#define USB_DT_HID = 0x21, /**< Descriptor type for HID class. Used to describe HID device information such as country code and HID class specification release.*/
#define USB_DT_HID_REPORT = 0x22, /**< Descriptor type for HID report. Used to define the data format and the controls used by the HID device. */
#define USB_DT_HID_PHYSICAL = 0x23, /**< Descriptor type for HID physical descriptors (optional). Used to describe the physical characteristics of a device.*/

#define USB_HID_ITEM_REPORT_TYPE_MAIN = 0, /**< Main items are used to define the data fields in HID reports, such as Input, Output and Feature reports*/
#define USB_HID_ITEM_REPORT_TYPE_GLOBAL = 1, /**< Global items apply to all the subsequent items in the report descriptor and define characteristics such as usage page, logical minimum, logical maximum, etc*/
#define USB_HID_ITEM_REPORT_TYPE_LOCAL = 2, /**< Local items define characteristics that are specific to a particular item, such as usage or designator index*/
#define USB_HID_ITEM_REPORT_TYPE_LONG = 3, /**< Long items are not commonly used but are available for future expansion and allow for extended data fields that are not defined by the standard HID item types*/

#define USB_HID_REPORT_TYPE_INPUT = 1, /**< Input reports are sent by the HID device to the host to report the state of the input controls*/
#define USB_HID_REPORT_TYPE_OUTPUT = 2, /**< Output reports are sent by the host to the HID device to control the state of the output controls*/
#define USB_HID_REPORT_TYPE_FEATURE = 3, /**< Feature reports are used to exchange feature data between the host and the HID device that may not be directly tied to input or output, such as configuration data*/

#define USB_HID_PROTOCOL_BOOT = 0, /**< Boot protocol is a simplified protocol that supports a limited set of HID devices*/
#define USB_HID_PROTOCOL_REPORT = 1, /**< Report protocol provides a more complex and feature-rich means of communication between the HID device and the host*/

#define USB_HID_BCD_V1_11 0x0111
#define USB_HID_NUM_DESC 0x01

#define USB_HID_NO_COUNTRY_CODE 0            // Not Supported
#define USB_HID_COUNTRY_ARABIC 1             // Arabic
#define USB_HID_COUNTRY_BELGIAN 2            // Belgian
#define USB_HID_COUNTRY_CANADIAN_BILINGUAL 3 // Canadian-Bilingual
#define USB_HID_COUNTRY_CANADIAN_FRENCH 4    // Canadian-French
#define USB_HID_COUNTRY_CZECH_REPUBLIC 5     // Czech Republic
#define USB_HID_COUNTRY_DANISH 6             // Danish
#define USB_HID_COUNTRY_FINNISH 7            // Finnish
#define USB_HID_COUNTRY_FRENCH 8             // French
#define USB_HID_COUNTRY_GERMAN 9             // German
#define USB_HID_COUNTRY_GREEK 10             // Greek
#define USB_HID_COUNTRY_HEBREW 11            // Hebrew
#define USB_HID_COUNTRY_HUNGARY 12           // Hungary
#define USB_HID_COUNTRY_INTERNATIONAL_ISO 13 // International (ISO)
#define USB_HID_COUNTRY_ITALIAN 14           // Italian
#define USB_HID_COUNTRY_JAPAN_KATAKANA 15    // Japan (Katakana)
#define USB_HID_COUNTRY_KOREAN 16            // Korean
#define USB_HID_COUNTRY_LATIN_AMERICAN 17    // Latin American
#define USB_HID_COUNTRY_NETHERLANDS_DUTCH 18 // Netherlands/Dutch
#define USB_HID_COUNTRY_NORWEGIAN 19         // Norwegian
#define USB_HID_COUNTRY_PERSIAN_FARSI 20     // Persian (Farsi)
#define USB_HID_COUNTRY_POLAND 21            // Poland
#define USB_HID_COUNTRY_PORTUGUESE 22        // Portuguese
#define USB_HID_COUNTRY_RUSSIA 23            // Russia
#define USB_HID_COUNTRY_SLOVAKIA 24          // Slovakia
#define USB_HID_COUNTRY_SPANISH 25           // Spanish
#define USB_HID_COUNTRY_SWEDISH 26           // Swedish
#define USB_HID_COUNTRY_SWISS_FRENCH 27      // Swiss/French
#define USB_HID_COUNTRY_SWISS_GERMAN 28      // Swiss/German
#define USB_HID_COUNTRY_SWITZERLAND 29       // Switzerland
#define USB_HID_COUNTRY_TAIWAN 30            // Taiwan
#define USB_HID_COUNTRY_TURKISH_Q 31         // Turkish-Q
#define USB_HID_COUNTRY_UK 32                // UK
#define USB_HID_COUNTRY_US 33                // US
#define USB_HID_COUNTRY_YUGOSLAVIA 34        // Yugoslavia
#define USB_HID_COUNTRY_TURKISH_F 35         // Turkish-F
