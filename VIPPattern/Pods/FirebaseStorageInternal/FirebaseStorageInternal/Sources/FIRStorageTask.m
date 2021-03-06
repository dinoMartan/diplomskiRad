// Copyright 2017 Google
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "FirebaseStorageInternal/Sources/Public/FirebaseStorageInternal/FIRStorageTask.h"

#import "FirebaseStorageInternal/Sources/Public/FirebaseStorageInternal/FIRStorage.h"
#import "FirebaseStorageInternal/Sources/Public/FirebaseStorageInternal/FIRStorageReference.h"
#import "FirebaseStorageInternal/Sources/Public/FirebaseStorageInternal/FIRStorageTaskSnapshot.h"

#import "FirebaseStorageInternal/Sources/FIRStorageReference_Private.h"
#import "FirebaseStorageInternal/Sources/FIRStorageTaskSnapshot_Private.h"
#import "FirebaseStorageInternal/Sources/FIRStorageTask_Private.h"
#import "FirebaseStorageInternal/Sources/FIRStorage_Private.h"

#if SWIFT_PACKAGE
@import GTMSessionFetcherCore;
#else
#import <GTMSessionFetcher/GTMSessionFetcherService.h>
#endif

@implementation FIRIMPLStorageTask

- (instancetype)init {
  @throw [NSException exceptionWithName:@"Attempt to call unavailable initializer."
                                 reason:@"init unavailable, use designated initializer"
                               userInfo:nil];
}

- (instancetype)initWithReference:(FIRIMPLStorageReference *)reference
                   fetcherService:(GTMSessionFetcherService *)service
                    dispatchQueue:(dispatch_queue_t)queue {
  self = [super init];
  if (self) {
    _reference = reference;
    _baseRequest = [FIRStorageUtils defaultRequestForReference:reference];
    _fetcherService = service;
    _fetcherService.maxRetryInterval = _reference.storage.maxOperationRetryInterval;
    _dispatchQueue = queue;
  }
  return self;
}

- (FIRIMPLStorageTaskSnapshot *)snapshot {
  @synchronized(self) {
    NSProgress *progress = [NSProgress progressWithTotalUnitCount:self.progress.totalUnitCount];
    progress.completedUnitCount = self.progress.completedUnitCount;
    FIRIMPLStorageTaskSnapshot *snapshot =
        [[FIRIMPLStorageTaskSnapshot alloc] initWithTask:self
                                                   state:self.state
                                                metadata:self.metadata
                                               reference:self.reference
                                                progress:progress
                                                   error:[self.error copy]];
    return snapshot;
  }
}

- (void)dispatchAsync:(void (^)(void))block {
  dispatch_async(self.dispatchQueue, block);
}

@end
