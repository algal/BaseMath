import XCTest
@testable import BaseMath

protocol TestProtocol {
  associatedtype T:FloatVector
  typealias E=T.Element
  var v1:T {get}
  var v2:T {get}
  var z:E {get}
}

class BaseMathTestsFloat: XCTestCase,TestProtocol {
  typealias T=Array<Float>

  let v1:T = [1.0, -2,  3, 0]
  let v2:T = [0.5, 12, -2, 1]
  let z:E = 0.0
}
class BaseMathTestsDouble: XCTestCase,TestProtocol {
  typealias T=Array<Double>

  let v1:T = [1.0, -2,  3, 0]
  let v2:T = [0.5, 12, -2, 1]
  let z:E = 0.0
}

extension TestProtocol {
  func testSum() {
    let exp = v1.reduce(z, +)
    XCTAssertEqual(v1.sum(), exp)
  }

  func testAbs() {
    let exp = T(v1.map {abs($0)})
    let r1 = v1.abs()
    XCTAssertEqual(r1, exp)
    let r2 = v1.copy()
    v1.abs(r2)
    XCTAssertEqual(r2, exp)
    v1.abs_()
    XCTAssertEqual(v1, exp)
  }

  func testAdd() {
    let exp = T(zip(v1,v2).map(+))
    let r1 = v1.add(v2)
    XCTAssertEqual(r1, exp, "add(v2)")
    let r2 = v1.copy()
    v1.add(v2, r2)
    XCTAssertEqual(r2, exp, "add(v2,r2)")
    let r3 = v1 + v2
    XCTAssertEqual(r3, exp, "+")
    let r4 = v1.copy()
    r4.add_(v2)
    XCTAssertEqual(r4, exp, "add_")
    let r5 = v1.copy()
    r5 += v2
    XCTAssertEqual(r5, exp, "+=")
  }

  func testDiv() {
    let v:E = 2.0
    let exp = T(v1.map {$0/v})
    let r1 = v1.div(v)
    XCTAssertEqual(r1, exp)
    let r2 = v1.copy()
    v1.div(v, r2)
    XCTAssertEqual(r2, exp)
    let r3 = v1 / v
    XCTAssertEqual(r3, exp)
    let r4 = v1.copy()
    r4.div_(v)
    XCTAssertEqual(r4, exp)
    let r5 = v1.copy()
    r5 /= v
    XCTAssertEqual(r5, exp)
  }

  func testSubRev() {
    let v:E = 2.0
    let exp = T(v1.map {v-$0})
    let r1 = v1.subRev(v)
    XCTAssertEqual(r1, exp)
    let r2 = v1.copy()
    v1.subRev(v, r2)
    XCTAssertEqual(r2, exp)
    let r3 = v - v1 
    XCTAssertEqual(r3, exp)
    let r4 = v1.copy()
    r4.subRev_(v)
    XCTAssertEqual(r4, exp)
  }

  func testPow() {
    let exp = T(zip(v1,v2).map({$0.pow($1)}))
    let r1 = v1.pow(v2)
    XCTAssertEqual(r1, exp)
    let r2 = v1.copy()
    v1.pow(v2, r2)
    XCTAssertEqual(r2, exp)
    v1.pow_(v2)
    XCTAssertEqual(v1, exp)
  }
}

