# cc-integration

Home for documents and tools related to device integration into Chameleon cloud.

## Integrations

### Initial Trial Integration

Our first integration is very straightfoward.

For every small set of EP devices (NVIDIA Nano, TX2, etc) will be paired with a CC Haswell machine which acts as a proxy to those devices.

The ownership policy is: reservation of a proxy boxes is equivalent to reservation of its EP devices.

```text
  CC Network
--------+----------------------
        |
        | NIC1
        |
  [ CC Proxy Box ]
        |
        | NIC2
        |
    [ Switch ]
      | | |
  [ EP 1, 2, ... ]
```
