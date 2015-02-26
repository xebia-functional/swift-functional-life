/*
* Copyright (C) 2015 47 Degrees, LLC http://47deg.com hello@47deg.com
*
* Licensed under the Apache License, Version 2.0 (the "License"); you may
* not use this file except in compliance with the License. You may obtain
* a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import Foundation

class FLFunctionalHelper: NSObject {
    
    class func immutableAppend<T>(sourceArray: Array<T>, itemToAdd: T) -> Array<T> {
        var tempArray = sourceArray
        tempArray.append(itemToAdd)
        
        let result = tempArray
        return result
    }

    class func flatMap<T, U>(xs: [T], f: T -> [U]) -> [U] {
        return xs.reduce([]) { $0 + f($1) }
    }
    
}
