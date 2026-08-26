; File: Hal/HAL_USB_DEF.S
; Description: USB Device Controller Definitions for AVR-DU family.
;

; USB Global State machine
#define USB_STATUS_DETACHED                         0x00
#define USB_STATUS_ATTACHED                         0x01
#define USB_STATUS_POWERED                          0x02
#define USB_STATUS_DEFAULT                          0x03
#define USB_STATUS_ADDRESS                          0x04
#define USB_STATUS_CONFIGURED                       0x05
#define USB_STATUS_SUSPEND                          0x06

; USB EP0 State Machine
#define USB_EP0_STATE_IDLE                          0x00
#define USB_EP0_STATE_DECODE_SETUP                  0x01
#define USB_EP0_STATE_DATA_IN                       0x02
;#define USB_EP0_STATE_DATA_OUT                      0x03
;#define USB_EP0_STATE_DATA_OUT_WAIT                 0x04
#define USB_EP0_STATE_DATA_IN_SEND                  0x05
#define USB_EP0_STATE_STALL                         0x06
#define USB_EP0_STATE_DONE                          0x07

; USB Table Offsets
#define USB_FIFO_OFFSET                             32
#define USB_EP_EP_OFFSET                            16
#define USB_FRAME_NUM_OFFSET                        (16*16)

#define USB_EP_OUT_STATUS                           0
#define USB_EP_OUT_CTRL                             1
#define USB_EP_OUT_CNT                              2
#define USB_EP_OUT_DATAPTR                          4
#define USB_EP_OUT_MCNT                             6
#define USB_EP_IN_STATUS                            8+0
#define USB_EP_IN_CTRL                              8+1
#define USB_EP_IN_CNT                               8+2
#define USB_EP_IN_DATAPTR                           8+4
#define USB_EP_IN_MCNT                              8+6

; USB EP Status Bits
#define USB_EP_READY_bm                             0x80
#define USB_EP_BUSY_bm                              0x01
#define USB_TOGGLE_bm                               0x01

#define USB_EP_TYPE_CONTROL                         0x00       /**<Control transfer type*/
#define USB_EP_TYPE_ISOCHRONOUS                     0x1       /**<Isochronous transfer type*/
#define USB_EP_TYPE_BULK                            2       /**<Bulk transfer type*/
#define USB_EP_TYPE_INTERRUPT                       0x3       /**<Interrupt transfer type*/
#define USB_EP_TYPE_DISABLED                        0xff    /**<Endpoint disabled*/

#define USB_EP_DIR_IN                               0x01
#define USB_EP_DIR_OUT                              0x00
#define OVERFLOW_EVENT                              1
#define UNDERFLOW_EVENT                             2
#define USB_V2_0                                    0x0200
#define USB_V2_1                                    0x0201
#define NO_SUBCLASS                                 0x00
#define NO_PROTOCOL                                 0x00
#define CLASS_IAD                                   0xEF
#define SUB_CLASS_IAD                               0x02
#define PROTOCOL_IAD                                0x01
#define USB_ENDPOINT_FEATURE_HALT                   0x00

#define USB_NO_DEVICE_CLASS                         0x00 // Use class code info from Interface Descriptors
#define USB_AUDIO_DEVICE_CLASS                      0x01 // Audio device
#define USB_CDC_DEVICE_CLASS                        0x02 // Communications and CDC Control
#define USB_HID_DEVICE_CLASS                        0x03 // HID (Human Interface Device)
#define USB_PHYSICAL_DEVICE_CLASS                   0x05 // Physical device
#define USB_IMAGE_DEVICE_CLASS                      0x06 // Still imaging device
#define USB_PRINTER_DEVICE_CLASS                    0x07 // Printer device
#define USB_MASS_STORAGE_DEVICE_CLASS               0x08 // Mass storage device
#define USB_HUB_DEVICE_CLASS                        0x09 // Hub
#define USB_CDC_DATA_DEVICE_CLASS                   0x0A // CDC data device
#define USB_SMART_CARD_DEVICE_CLASS                 0x0B // Smart Card device
#define USB_CONTENT_SECURITY_DEVICE_CLASS           0x0D // Content security device
#define USB_VIDEO_DEVICE_CLASS                      0x0E // Video device
#define USB_PERSONAL_HEALTHCARE_DEVICE_CLASS        0x0F // Personal healthcare device
#define USB_AUDIO_VIDEO_DEVICE_CLASS                0x10 // Audio/Video devices
#define USB_BILLBOARD_DEVICE_CLASS                  0x11 // Billboard device
#define USB_TYPE_C_BRIDGE_DEVICE_CLASS              0x12 // USB Type-C bridge device
#define USB_BULK_DISPLAY_PROTOCOL_DEVICE_CLASS      0x13 // USB Bulk display protocol device
#define USB_MCTP_DEVICE_CLASS                       0x14 // MCTP over USB protocol endpoint device
#define USB_I3C_DEVICE_CLASS                        0x3C // I3C device
#define USB_DIAGNOSTIC_DEVICE_CLASS                 0xDC // Diagnostic device
#define USB_WIRELESS_DEVICE_CLASS                   0xE0 // Wireless controller
#define USB_MISC_DEVICE_CLASS                       0xEF // Miscellaneous
#define USB_APPLICATION_DEVICE_CLASS                0xFE // Application specific
#define USB_VENDOR_DEVICE_CLASS                     0xFF // Vendor specific

#define USB_REQUEST_DIR_MASK                        0x80
#define USB_REQUEST_DIR_OUT                         0x00 // Host → Device
#define USB_REQUEST_DIR_IN                          0x80 // Device → Host
#define USB_REQUEST_DIR_bp                          7    // Bit position of the direction field in the bmRequestType field

#define USB_REQUEST_TYPE_MASK                       0x60 // Request Type Mask
#define USB_REQUEST_TYPE_STANDARD                   0x00 // Standard USB request defined in the USB specification
#define USB_REQUEST_TYPE_CLASS                      0x20 // Class-specific request defined in the USB Class Specification
#define USB_REQUEST_TYPE_VENDOR                     0x40 // Vendor-specific request not defined in the USB Specification

#define USB_REQUEST_RECIPIENT_MASK                  0x1F
#define USB_REQUEST_RECIPIENT_DEVICE                0x00 // Request is directed at the entire USB device
#define USB_REQUEST_RECIPIENT_INTERFACE             0x01 // Request is directed at an interface within the USB device
#define USB_REQUEST_RECIPIENT_ENDPOINT              0x02 // Request is directed at an endpoint within an interface
#define USB_REQUEST_RECIPIENT_OTHER                 0x03 // Request is directed at another specific recipient

#define USB_REQUEST_GET_STATUS                      0x00 // Retrieve status information, such as device power status or endpoint stall conditions
#define USB_REQUEST_CLEAR_FEATURE                   0x01 // Clear or reset specific device or component features, like clearing an endpoint halt condition
#define USB_REQUEST_SET_FEATURE                     0x03 // Set or enable specific device or component features, often used to configure device behavior
#define USB_REQUEST_SET_ADDRESS                     0x05 // Assign a unique device address during enumeration
#define USB_REQUEST_GET_DESCRIPTOR                  0x06 // Request descriptor information, specifying the type of descriptor being requested
#define USB_REQUEST_SET_DESCRIPTOR                  0x07 // Update certain descriptors
#define USB_REQUEST_GET_CONFIGURATION               0x08 // Retrieve the currently selected device configuration
#define USB_REQUEST_SET_CONFIGURATION               0x09 // Select a specific device configuration
#define USB_REQUEST_GET_INTERFACE                   0x0A // Retrieve the currently selected alternate setting of an interface
#define USB_REQUEST_SET_INTERFACE                   0x0B // Select a specific alternate setting for an interface
#define USB_REQUEST_SYNCH_FRAME                     0x0C // Retrieve synchronization information for isochronous transfers

#define USB_DESCRIPTOR_TYPE_DEVICE                      0x01 // Provides essential information about the USB device
#define USB_DESCRIPTOR_TYPE_CONFIGURATION               0x02 // Describes a specific configuration of the device
#define USB_DESCRIPTOR_TYPE_STRING                      0x03 // Contains human-readable string information
#define USB_DESCRIPTOR_TYPE_INTERFACE                   0x04 // Specifies the characteristics of a single interface within a configuration
#define USB_DESCRIPTOR_TYPE_ENDPOINT                    0x05 // Defines the characteristics of a specific endpoint within an interface
#define USB_DESCRIPTOR_TYPE_DEVICE_QUALIFIER            0x06 // For high-speed USB devices, informs the host if the device has different device information for when operating in full-speed
#define USB_DESCRIPTOR_TYPE_OTHER_SPEED_CONFIGURATION   0x07 // Provides details about the configuration of a device for a specific speed when operating at high-speed
#define USB_DESCRIPTOR_TYPE_INTERFACE_POWER             0x08 // Specifies the amount of power that an interface of a USB device consumes when it's active
#define USB_DESCRIPTOR_TYPE_IAD                         0x0B // Interface Association Descriptor which associates a group of interfaces that form a single function, helping to manage composite devices
#define USB_DESCRIPTOR_TYPE_BOS                         0x0F // Binary Object Store Descriptor which provides information about the capabilities of the device
#define USB_DESCRIPTOR_TYPE_DEVICE_CAPABILITY           0x10 // Describes specific capabilities and features supported by the device, such as USB Power Delivery or USB 2.0 features
#define USB_DESCRIPTOR_TYPE_CLASS                       0x20 // Class descriptor types are from 0x20 to 0x3f
#define USB_DESCRIPTOR_TYPE_VENDOR                      0x40 // Vendor descriptor types are from 0x40 to 0x5f

#define USB_CONFIG_ATTR_MUST_SET                        0x80 // Must always be set
#define USB_CONFIG_ATTR_BUS_POWERED                     0x00 // Bus-Powered
#define USB_CONFIG_ATTR_SELF_POWERED                    0x40 // Self-Powered
#define USB_CONFIG_ATTR_REMOTE_WAKEUP                   0x20 // Remote wakeup supported
#define USB_CONFIG_MAX_POWER(ma)            (((ma) + 1) / 2) // Maximum power in mA

#define USB_REQUEST_DEVICE_SELF_POWERED                 0x01 // Self-Powered
#define USB_REQUEST_DEVICE_REMOTE_WAKEUP                0x02 // Remote Wake-up supported
#define USB_REQUEST_DEVICE_DISABLE_CONFIGURATION        0x00 // Disable Configuration


/* Setup function for the device requests
 * USB 2.0 Specification Ch 9.4.
 * | bRequest          | wValue            | wIndex     | wLength | Data                |
 * |-------------------|-------------------|------------|---------|---------------------|
 * | CLEAR_FEATURE     | Feature selector  | Zero       | Zero    | None                |
 * | GET_CONFIGURATION | Zero              | Zero       | One     | Config value        |
 * | GET_DESCRIPTOR    | Type and index    | Zero or ID | Length  | Descriptor          |
 * | GET_STATUS        | Zero              | Endpoint   | Two     | Device status       |
 * | SET_ADDRESS       | Device address    | Zero       | Zero    | None                |
 * | SET_CONFIGURATION | Config value      | Zero       | Zero    | None                |
 * | SET_DESCRIPTOR    | Type and index    | Zero or ID | Length  | Descriptor          |
 * | SET_FEATURE       | Feature selector  | Zero       | Zero    | None                |
 *
 * Setup function for the endpoint requests
 * USB 2.0 Specification Ch. 9.4.
 * | bRequest      | wValue           | wIndex   | wLength | Data            |
 * |---------------|------------------|----------|---------|-----------------|
 * | CLEAR_FEATURE | Feature selector | Endpoint | Zero    | None            |
 * | GET_STATUS    | Zero             | Endpoint | Two     | Endpoint status |
 * | SET_FEATURE   | Feature selector | Endpoint | Zero    | None            |
 * | SYNCH_FRAME   | Zero             | Endpoint | Two     | Frame number    |
 *
 * Setup function for the interface requests
 * USB 2.0 Specification Ch 9.4.
 * | bRequest        | wValue            | wIndex    | wLength | Data                |
 * |-----------------|-------------------|-----------|---------|---------------------|
 * | CLEAR_FEATURE   | Feature selector  | Interface | Zero    | None                |
 * | GET_INTERFACE   | Zero              | Interface | One     | Alternate interface |
 * | GET_STATUS      | Zero              | Interface | Two     | Interface           |
 * | SET_FEATURE     | Feature selector  | Interface | Zero    | None                |
 * | SET_INTERFACE   | Alternate setting | Interface | Zero    | None                |
 * | GET_DESCRIPTOR  | Type and index    | Zero      | Length  | Descriptor          |
 */