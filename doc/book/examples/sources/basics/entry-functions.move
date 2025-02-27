// Copyright (c) 2022, Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

module examples::object {
    use sui::transfer;
    use sui::id::VersionedID;
    use sui::tx_context::{Self, TxContext};

    struct Object has key {
        id: VersionedID
    }

    /// If function is defined as public - any module can call it.
    /// Non-entry functions are also allowed to have return values.
    public fun create(ctx: &mut TxContext): Object {
        Object { id: tx_context::new_id(ctx) }
    }

    /// Entrypoints can't have return values as they can only be called
    /// directly in a transaction and the returned value can't be used.
    /// However, `entry` without `public` disallows calling this method from
    /// other Move modules.
    entry fun create_and_transfer(to: address, ctx: &mut TxContext) {
        transfer::transfer(create(ctx), to)
    }
}
