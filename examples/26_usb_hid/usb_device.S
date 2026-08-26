
#define USB_ENDPOINTS                      1

.section .progmem.rodata
/* 
 * USB Device Descriptor 
 * Contains basic information about the USB device, such as compliance level, 
 * device class, vendor ID, product ID, and serial number string index.
 */
USB_DEVICE_DESC:
    .byte 18                             ; bLength (18 bytes)
    .byte USB_DESCRIPTOR_TYPE_DEVICE     ; bDescriptorType (Device Descriptor)
    .word USB_V2_0                       ; bcdUSB: USB Specification Release Number (2.0)
    .byte USB_NO_DEVICE_CLASS            ; bDeviceClass: (0x00, defer to interfaces)
    .byte 0x00                           ; bDeviceSubClass (0x00)
    .byte 0x00                           ; bDeviceProtocol (0x00)
    .byte 64                             ; bMaxPacketSize0: Maximum packet size for Endpoint 0 (64 bytes)
    .word 0x04D8                         ; idVendor: Vendor ID (Microchip Technology Inc. - 0x04D8)
    .word 0x0055                         ; idProduct: Product ID (0x0055)
    .word 0x0001                         ; bcdDevice: Device Release Number (1.00)
    .byte 0x01                           ; iManufacturer: Index of Manufacturer string descriptor
    .byte 0x02                           ; iProduct: Index of Product string descriptor
    .byte 0x03                           ; iSerialNumber: Index of Serial Number string descriptor
    .byte 1                              ; bNumConfigurations: Number of configurations (1)

/* 
 * USB Configuration Descriptor Block
 * Includes Configuration, Interface, HID, and Endpoint Descriptors.
 * When the host requests the Configuration descriptor, all these nested descriptors are returned.
 */
USB_DEVICE_CONF:
    ; --- Configuration Descriptor ---
    .byte 9                              ; bLength (9 bytes)
    .byte USB_DESCRIPTOR_TYPE_CONFIGURATION ; bDescriptorType (Configuration Descriptor)
    .byte 34, 0                          ; wTotalLength: Total length of data returned for this configuration (34 bytes)
    .byte 1                              ; bNumInterfaces: Number of interfaces (1)
    .byte 1                              ; bConfigurationValue: Value to use as an argument to Set Configuration
    .byte 0                              ; iConfiguration: Index of string descriptor describing this configuration (0 = none)
    .byte USB_CONFIG_ATTR_MUST_SET | USB_CONFIG_ATTR_SELF_POWERED ; bmAttributes: Self-Powered, Bus-Powered
    .byte USB_CONFIG_MAX_POWER(50)       ; bMaxPower: Max power consumption in 2mA units (100mA)

    ; --- Interface Descriptor ---
    .byte 9                              ; bLength (9 bytes)
    .byte USB_DESCRIPTOR_TYPE_INTERFACE  ; bDescriptorType (Interface Descriptor)
    .byte 0                              ; bInterfaceNumber: Number of this interface (0)
    .byte 0                              ; bAlternateSetting: Value used to select this alternate setting (0)
    .byte 1                              ; bNumEndpoints: Number of endpoints used by this interface (1, excluding EP0)
    .byte USB_HID_DEVICE_CLASS           ; bInterfaceClass: HID (Human Interface Device) Class (3)
    .byte HID_SUB_CLASS_NOBOOT           ; bInterfaceSubClass: Subclass (0 = No Boot subclass)
    .byte HID_PROTOCOL_KEYBOARD          ; bInterfaceProtocol: Protocol (1 = Keyboard)
    .byte 0                              ; iInterface: Index of string descriptor describing this interface (0 = none)

    ; --- HID Descriptor ---
    .byte 9                              ; bLength (9 bytes)
    .byte USB_DT_HID                     ; bDescriptorType (HID Descriptor)
    .word 0x0111                         ; bcdHID: HID Class Specification release (1.11)
    .byte USB_HID_COUNTRY_US             ; bCountryCode: Country code of localized hardware (US)
    .byte 1                              ; bNumDescriptors: Number of class descriptors (1)
    .byte USB_DT_HID_REPORT              ; bDescriptorType: Report descriptor type
    .word USB_HID_REPORT_DESCRIPTOR_SIZE ; wDescriptorLength: Total length of Report Descriptor (59 bytes)

    ; --- Endpoint Descriptor (EP1 IN) ---
    .byte 7                              ; bLength (7 bytes)
    .byte USB_DESCRIPTOR_TYPE_ENDPOINT   ; bDescriptorType (Endpoint Descriptor)
    .byte 0x81                           ; bEndpointAddress (EP1 IN direction: 0x80 | 1)
    .byte USB_EP_TYPE_INTERRUPT          ; bmAttributes: Interrupt transfer type (3)
    .word 64                             ; wMaxPacketSize: Maximum packet size (64 bytes)
    .byte 10                             ; bInterval: Polling interval in ms (10ms)

/*
 * USB HID Report Descriptor
 * Defines the format of the reports sent between the host and the keyboard.
 * Represents a standard keyboard with modifier keys and key codes.
 */
USB_HID_REPORT_DESC:
    .byte 0x05, 0x01, 0x09, 0x06, 0xa1, 0x01, 0x05, 0x07
    .byte 0x19, 0xe0, 0x29, 0xe7, 0x15, 0x00, 0x25, 0x01
    .byte 0x75, 0x01, 0x95, 0x08, 0x81, 0x02, 0x95, 0x01
    .byte 0x75, 0x08, 0x81, 0x03, 0x95, 0x05, 0x75, 0x01
    .byte 0x05, 0x08, 0x19, 0x01, 0x29, 0x05, 0x91, 0x02
    .byte 0x95, 0x01, 0x75, 0x03, 0x91, 0x03, 0x95, 0x06
    .byte 0x75, 0x08, 0x15, 0x00, 0x25, 0x65, 0x05, 0x07
    .byte 0x19, 0x00, 0x29, 0x65, 0x81, 0x00, 0xc0

/* 
 * USB String Descriptors
 * String descriptor 0 contains the supported Language IDs.
 * Other strings contain Manufacturer, Product, and Serial number in UTF-16LE.
 */
USB_STR_0: 
    .byte 4, 3
    .word 0x0409                         ; Language ID: English (United States) - 0x0409
    
USB_STR_1: 
    .byte 20, 3                          ; Length: 20 bytes, Descriptor Type: String (3)
    .ascii "M\0i\0c\0r\0o\0c\0h\0i\0p\0" ; Manufacturer string (UTF-16LE)
    
USB_STR_2: 
    .byte 22, 3                          ; Length: 22 bytes, Descriptor Type: String (3)
    .ascii "A\0V\0R\0 \0U\0S\0B\0 \0K\0B\0" ; Product string (UTF-16LE)
    
USB_STR_3: 
    .byte 4, 3                           ; Length: 4 bytes, Descriptor Type: String (3)
    .ascii "1\0"                         ; Serial number string (UTF-16LE)

/*
 * Message Keycodes
 * Sequence of HID usage codes corresponding to 'h', 'e', 'l', 'l', 'o'
 */
MSG_HELLO: 
    .byte 0x0B, 0x08, 0x0F, 0x0F, 0x12  ; HID Key codes for 'h', 'e', 'l', 'l', 'o'

