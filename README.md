# wasmcloud-interface-sleepy
Interface definitions for the "jclmnop:sleepy" capability contract. This 
contract allows actors to sleep for a specified duration, and also to 
retrieve the current system time on the wasmcloud host. 

Useful for implementing rate limits or other time-based functionality.

## Example
```rust
use wasmcloud_interface_sleepy::SleepySender;
use wasmbus_rpc::actor::prelude::*;
use wasmbus_rpc::Timestamp;

async fn sleep_for_5_seconds(ctx: &Context) -> RpcResult<()> {
    let sleepy = SleepySender::new();
    sleepy.sleep(ctx, &5).await?;
}

async fn sleep_until_5_seconds(ctx: &Context) -> RpcResult<()> {
    let sleepy = SleepySender::new();
    let now = sleepy::now();
    let five_seconds = Timestamp::new(now.sec + 5, now.nsec);
    sleepy.sleep_until(ctx, &five_seconds).await?;
}

async fn get_current_time(ctx: &Context) -> RpcResult<Timestamp> {
    let sleepy = SleepySender::new();
    sleepy.now(ctx).await
}
```