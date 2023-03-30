// sleepy-interface.smithy

// Tell the code generator how to reference symbols defined in this namespace
metadata package = [ { namespace: "jclmnop.provider.sleepy", crate: "wasmcloud-interface-sleepy" } ]

namespace jclmnop.provider.sleepy

use org.wasmcloud.model#wasmbus
use org.wasmcloud.model#U32

/// Allows actors to `sleep` for a specified duration, or until a desired time.
/// contractId: "jclmnop:sleepy"
@wasmbus(
  contractId: "jclmnop:sleepy",
  providerReceive: true,
)

service Sleepy {
  version: "0.1",
  operations: [ Sleep, SleepUntil ]
}

/// Sleep for a specified number of milliseconds
/// ```
/// # use wasmcloud_interface_sleepy::SleepySender;
/// # async fn sleep_for_5_seconds() {
///   let sleepy = SleepySender::new();
///   // sleep for 5 seconds
///   sleepy.sleep(5000).await;
/// # }
operation Sleep {
  input: U32,
}

/// Sleep until a specified time, provided as a `wasmbus_rpc::Timestamp` struct.
/// If the specified time is in the past, the operation will return immediately.
/// ```
/// # use wasmcloud_interface_sleepy::SleepySender;
/// # use wasmbus_rpc::Timestamp;
/// # async fn sleep_until_5_seconds() {
///  let sleepy = SleepySender::new();
///  let now = Timestamp::now();
///  let five_seconds = Timestamp::new(now.sec + 5, now.nsec);
///  // sleep until 5 seconds from now
///  sleepy.sleep_until(five_seconds).await;
///  # }
operation SleepUntil {
  input: Timestamp,
}

