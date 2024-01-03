export const getPagination = ({ offset, limit, total }: { offset: number, limit: number, total: number }) => {
    const currentPage = offset ? offset / limit + 1 : 1;
    const totalPages = Math.ceil(total / limit);
    const hasNextPage = currentPage < totalPages;
    const hasPreviousPage = currentPage > 1;
    return {
        currentPage,
        totalPages,
        hasNextPage,
        hasPreviousPage,
        totalItems: total,
    };
};