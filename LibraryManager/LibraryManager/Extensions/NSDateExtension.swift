import Foundation

public extension NSDate {
    
    public func plusSeconds(s: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: Int(s), minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    public func minusSeconds(s: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: -Int(s), minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    public func plusMinutes(m: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: Int(m), hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    public func minusMinutes(m: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: -Int(m), hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    public func plusHours(h: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: Int(h), days: 0, weeks: 0, months: 0, years: 0)
    }
    
    public func minusHours(h: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: -Int(h), days: 0, weeks: 0, months: 0, years: 0)
    }
    
    public func plusDays(d: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: Int(d), weeks: 0, months: 0, years: 0)
    }
    
    public func minusDays(d: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: -Int(d), weeks: 0, months: 0, years: 0)
    }
    
    public func plusWeeks(w: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: Int(w), months: 0, years: 0)
    }
    
    public func minusWeeks(w: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: -Int(w), months: 0, years: 0)
    }
    
    public func plusMonths(m: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: Int(m), years: 0)
    }
    
    public func minusMonths(m: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: -Int(m), years: 0)
    }
    
    public func plusYears(y: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: Int(y))
    }
    
    public func minusYears(y: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: -Int(y))
    }
    
    private func addComponentsToDate(seconds sec: Int, minutes min: Int, hours hrs: Int, days d: Int, weeks wks: Int, months mts: Int, years yrs: Int) -> NSDate {
        let dc: NSDateComponents = NSDateComponents()
        dc.second = sec
        dc.minute = min
        dc.hour = hrs
        dc.day = d
        dc.weekOfYear = wks
        dc.month = mts
        dc.year = yrs
        return NSCalendar.currentCalendar().dateByAddingComponents(dc, toDate: self, options: [])!
    }
    
    public func midnightUTCDate() -> NSDate {
        let dc: NSDateComponents = NSCalendar.currentCalendar().components([.Year, .Month, .Day], fromDate: self)
        dc.hour = 0
        dc.minute = 0
        dc.second = 0
        dc.nanosecond = 0
        dc.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        
        return NSCalendar.currentCalendar().dateFromComponents(dc)!
    }
    
    public class func secondsBetween(date1 d1:NSDate, date2 d2:NSDate) -> Int {
        let dc = NSCalendar.currentCalendar().components(NSCalendarUnit.Second, fromDate: d1, toDate: d2, options:[])
        return dc.second
    }
    
    public class func minutesBetween(date1 d1: NSDate, date2 d2: NSDate) -> Int {
        let dc = NSCalendar.currentCalendar().components(NSCalendarUnit.Minute, fromDate: d1, toDate: d2, options: [])
        return dc.minute
    }
    
    public class func hoursBetween(date1 d1: NSDate, date2 d2: NSDate) -> Int {
        let dc = NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: d1, toDate: d2, options: [])
        return dc.hour
    }
    
    public class func daysBetween(date1 d1: NSDate, date2 d2: NSDate) -> Int {
        let dc = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: d1, toDate: d2, options: [])
        return dc.day
    }
    
    public class func weeksBetween(date1 d1: NSDate, date2 d2: NSDate) -> Int {
        let dc = NSCalendar.currentCalendar().components(NSCalendarUnit.WeekOfYear, fromDate: d1, toDate: d2, options: [])
        return dc.weekOfYear
    }
    
    public class func monthsBetween(date1 d1: NSDate, date2 d2: NSDate) -> Int {
        let dc = NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: d1, toDate: d2, options: [])
        return dc.month
    }
    
    public class func yearsBetween(date1 d1: NSDate, date2 d2: NSDate) -> Int {
        let dc = NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: d1, toDate: d2, options: [])
        return dc.year
    }
    
    //MARK- Comparison Methods
    
    public func isAfter(date: NSDate) -> Bool {
        return (self.compare(date) == .OrderedDescending)
    }
    
    public func isBefore(date: NSDate) -> Bool {
        return (self.compare(date) == .OrderedAscending)
    }
    
    //MARK- Computed Properties
    
    public var day: UInt {
        if #available(iOS 8.0, *) {
            return UInt(NSCalendar.currentCalendar().component(.Day, fromDate: self))
        } else {
            // Fallback on earlier versions
            let flags: NSCalendarUnit = NSCalendarUnit.Day
            let date = NSDate()
            let components = NSCalendar.currentCalendar().components(flags, fromDate: date)
            return UInt(components.day)
        }
    }
    
    public var month: UInt {
        if #available(iOS 8.0, *) {
            return UInt(NSCalendar.currentCalendar().component(.Month, fromDate: self))
        } else {
            // Fallback on earlier versions
            let flags: NSCalendarUnit = NSCalendarUnit.Month
            let date = NSDate()
            let components = NSCalendar.currentCalendar().components(flags, fromDate: date)
            return UInt(components.month)
        }
    }
    
    public var year: UInt {
        if #available(iOS 8.0, *) {
            return UInt(NSCalendar.currentCalendar().component(.Year, fromDate: self))
        } else {
            // Fallback on earlier versions
            let flags: NSCalendarUnit = NSCalendarUnit.Year
            let date = NSDate()
            let components = NSCalendar.currentCalendar().components(flags, fromDate: date)
            return UInt(components.year)
        }
    }
    
    public var hour: UInt {
        if #available(iOS 8.0, *) {
            return UInt(NSCalendar.currentCalendar().component(.Hour, fromDate: self))
        } else {
            // Fallback on earlier versions
            let flags: NSCalendarUnit = NSCalendarUnit.Hour
            let date = NSDate()
            let components = NSCalendar.currentCalendar().components(flags, fromDate: date)
            return UInt(components.hour)
        }
    }
    
    public var minute: UInt {
        if #available(iOS 8.0, *) {
            return UInt(NSCalendar.currentCalendar().component(.Minute, fromDate: self))
        } else {
            // Fallback on earlier versions
            let flags: NSCalendarUnit = NSCalendarUnit.Minute
            let date = NSDate()
            let components = NSCalendar.currentCalendar().components(flags, fromDate: date)
            return UInt(components.minute)
        }
    }
    
    public var second: UInt {
        if #available(iOS 8.0, *) {
            return UInt(NSCalendar.currentCalendar().component(.Second, fromDate: self))
        } else {
            // Fallback on earlier versions
            let flags: NSCalendarUnit = NSCalendarUnit.Second
            let date = NSDate()
            let components = NSCalendar.currentCalendar().components(flags, fromDate: date)
            return UInt(components.second)
        }
    }
}