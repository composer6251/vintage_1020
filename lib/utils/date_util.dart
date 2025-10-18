String getMonthDayYearStringFromDateTime(DateTime? dateTime) {
  return dateTime != null
      ? '${dateTime.toLocal().month}/${dateTime.toLocal().day}/${dateTime.toLocal().year}'
      : 'Select Date';
}
